

% Prerequisites:
%
% 1. wsrlib installed (see bitbucket page)
%    compile: wsrlib_make (run once)
%    setup paths: wsrlib_setup (run every time you start MATLAB)
%
% 2.

label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');

% Examples
%  roosts(1) % struct
%  roosts(2) % struct
%  roosts(1).filename % filename of first roost

nRoosts = numel(roosts); % number of roosts
dataRoot = '/Users/saadiagabriel/Desktop';

dzmap = jet(32);     % colormap for reflectivity data (DZ)
vrmap = vrmap2(32);  % colormap for radial velocity data (VR)
dzPoints = zeros(327,1);


for i=1:nRoosts
    
    theRoost = roosts(i);
    
    fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        theRoost.station, theRoost.year, theRoost.month, theRoost.day, theRoost.filename);
        
    %fprintf(fileName);
   
    radar = rsl2mat(fileName, theRoost.station);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Visualize the scan in cartesian coordinates
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    rmax = 150000; % 150km
    dim  = 400;    % 400 pixels
    
    % reflectivity
    %figure(1);
    
    % convert to cartesian
    [z, x, y] = sweep2cart(radar.dz.sweeps(1), rmax, dim); % convert to cartesian
    
    % show the image
    %imagesc(x, y, z);
    %axis xy;
    %colormap(dzmap);
    %colorbar();
    
    % now plot the roost location
    %hold on;
    %plot(theRoost.x, theRoost.y, 'Marker', 'x', 'MarkerSize', 10, 'LineWidth', 5, 'color', 'red');
    folderName = sprintf('%s/%04d/%02d/%02d/%s/%04d', ...
        theRoost.station, theRoost.year, theRoost.month, theRoost.day, strrep(theRoost.filename,'.gz',''),theRoost.sequence_id);
    %mkdir('/Users/saadiagabriel/Desktop/plots/LowestSweep',folderName);
    %saveas(figure(1),fullfile(strcat('/Users/saadiagabriel/Desktop/plots/LowestSweep/',folderName), 'figure 1'),'jpeg');
    % radial velocity
    %     figure(2);
    %     [z, x, y] = sweep2cart(radar.vr.sweeps(1), rmax, dim); % conver to cartesian
    %     colormap(vrmap);
    %     imagesc(x, y, z); % see the image
    %     axis xy;
    %     colorbar();
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % - Extract all of the pulse volumes together with their coordinates
    %   in polar coordinate system.
    % - Use wsrlib utilities to convert to different coordinate systems
    % - Slice and dice (select PVs) using logical indexing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    AZ_RES    = 0.5;
    RANGE_RES = 250;
    RMAX_M    = 150000;
    
 
    % I put two alternatives below for which data to grab: either all of it
    % or just the lowest sweep. Let's use the lowest sweep for now.
 
    %    whichdata = 'all';
    whichdata = 'lowest-sweep';
    
    switch whichdata
        case 'all'
            radar_aligned = align_scan(radar, AZ_RES, RANGE_RES, RMAX_M );
            [data, range, az, elev] = radar2mat(radar_aligned, {'dz', 'vr'});
            DZ = data{1};
            VR = data{2};
        case 'lowest-sweep'
            sweep = radar.dz.sweeps(1);
            DZ = sweep.data;
            FLAG_START = 131067;
            DZ(DZ > FLAG_START) = nan;
            [az, range] = get_az_range(sweep);
            elev = sweep.elev;
    end
    
    Z  = idb(DZ);   % inverse decibel transformation
    
    % Sanity check: let's look at the first sweep of DZ in polar
    % coordinates and compare to our cartesian visualizations
    %     figure(3)
    %     imagesc(az, range, DZ(:,:,1));
    %     xlabel('Direction (degrees clockwise from north');
    %     ylabel('Range in m');
    %     axis xy;
    %     colormap(dzmap);
    %     colorbar();
    
    % Get coordinate matrices
    [RANGE, AZ, ELEV] = ndgrid(range, az, elev);
    [GROUND_RANGE, HEIGHT] = slant2ground(RANGE, ELEV);      % height (m above radar) of each pulse volume
    
    % Important point
    % - Have two data matrices (DZ and VR) and several "coordinate"
    %   matrices that have exactly the same dimensions.
    % - Do very nice things with logical indexing
    
    % Example
    %inds = AZ >= 200 & AZ <= 250;
    %x = DZ(inds); % all reflectivity values for pulse volumes with azimuth between 200 and 250
    
    % Get additional coordinate matrices by converting from polar to cartesian
    THETA = cmp2pol(AZ);              % compass heading to mathematical angle
    [X, Y] = pol2cart(THETA, RANGE);  % polar to cartesian
    
    % Find indices of pulse volumes within twice the radius of the center
    % of the roost
    x0 = theRoost.x;
    y0 = theRoost.y;
    radius = theRoost.r;
    DIST_FROM_ROOST = sqrt((X-x0).^2 + (Y-y0).^2);
    inds = DIST_FROM_ROOST <= 2*radius;
    inds = inds & ELEV <= 1;  % first elevation angle only
    
       
       %var(Z(inds),'omitnan')
       %mean(Z(inds),'omitnan')
      
    
    M = Z(inds);
    N = DIST_FROM_ROOST(inds);
    N = N(~isnan(M));
    M = M(~isnan(M));
    
    dzPoints(i) = size(M,1);
    
%     if (strcmp(fileName, '/Users/saadiagabriel/Desktop/KDOX/2011/10/25/KDOX20111025_110421_V04.gz'))
%         
%        theRoost.sequence_id
%         options = fitoptions('gauss1');
%        %options.Lower = [0 -Inf 0 0 -Inf 0];
%        %options.Upper = [0 100000 0 0 100000 0];
%        [generalCurve,gof] = fit(N,M,'gauss1');
%        [mean,variance] = meanVar(generalCurve);
%        figure(3);
%        plot(generalCurve,DIST_FROM_ROOST(inds), Z(inds));
%        xlabel('Distance From Roost Center');
%        ylabel('Reflectivity');
%        title(folderName);
%        %Draw a vertical line to show the actual radius
%        line([radius radius], ylim, 'Color', 'r', 'LineWidth', 2);
%     end 
    
    % Plot reflectivity vs. distance from roost center
    %figure(2);
    %plot(DIST_FROM_ROOST(inds), Z(inds), 'Marker', 'x', 'LineStyle', 'none');
    %xlabel('Distance From Roost Center');
    %ylabel('Reflectivity');
    % Draw a vertical line to show the actual radius
    %line([radius radius], ylim, 'Color', 'r', 'LineWidth', 2);
    
    %M = Z(inds);
    %N = DIST_FROM_ROOST(inds); 
    %N(isnan(M)) = 0;
    %M(isnan(M)) = 0; 
    
    
%     options = fitoptions('gauss1');
%     options.Lower = [0 0 0 0 0 0];
%     options.Upper = [0 Inf 0 0 Inf 0];
%     [generalCurve,gof] = fit(N,M,'gauss1');
%     figure(1);
%     plot(generalCurve,DIST_FROM_ROOST(inds), Z(inds));
%     xlabel('Distance From Roost Center');
%     ylabel('Reflectivity');
%     title(folderName);
    
%    if (strcmp(fileName, '/Users/saadiagabriel/Desktop/KDOX/2011/10/08/KDOX20111008_105458_V04.gz')&&(theRoost.sequence_id == 1655))...
%     || (strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_112758_V04.gz')&&(theRoost.sequence_id == 1635)) ...  
%         ||  (strcmp(fileName, '/Users/saadiagabriel/Desktop/KDOX/2011/10/07/KDOX20111007_110223_V04.gz')&&(theRoost.sequence_id == 1650)) ...
%             || (strcmp(fileName, '/Users/saadiagabriel/Desktop/KDOX/2011/10/18/KDOX20111018_110220_V04.gz')&&(theRoost.sequence_id == 1674)) ... 
%              || (strcmp(fileName, '/Users/saadiagabriel/Desktop/KDOX/2011/10/25/KDOX20111025_110421_V04.gz')&&(theRoost.sequence_id == 6323))
%          
%          % Plot reflectivity vs. distance from roost center
% %          hold on; 
% %          figure(1);
% %          [generalCurve,gof] = fit(N,M,'gauss1');
% %          plot1 = plot(generalCurve,DIST_FROM_ROOST(inds), Z(inds));
% %          %plot1.Color(4)= .1;
% %          xlabel('Distance From Roost Center');
% %          ylabel('Reflectivity');
%          
%            
%            
% %           N
% %           M
% %           [mu, sigma] = normfit(M);
% %           [m,v] =  normstat(mu,sigma);
%           
%                  options = fitoptions('gauss1', 'Upper', [0 Inf 0 0 Inf 0]);
%                  options.Lower = [0 .01 0 0 .01 0];
%                  options.Normalize = 'on';
%                  [generalCurve,gof] = fit(N,M,'gauss1',options);
%                  generalCurve.c1
%                  [mean, variance] = meanVar(generalCurve);
%                  plot(generalCurve,DIST_FROM_ROOST(inds), Z(inds));
%                  A = {theRoost.sequence_id mean variance radius }
% %                    A = {theRoost.sequence_id m v radius }
%                  
%                  %fileName
%                   %A = {theRoost.sequence_id mean variance radius }
% %                   xlRange = sprintf('A%d',i);
% %                   B = csvread('roosts.csv');
% %                   csvwrite(excel,A,sheet,xlRange);
% %                  figure(3);
% %                  plot(generalCurve,DIST_FROM_ROOST(inds), Z(inds));
% %                  xlabel('Distance From Roost Center');
% %                  ylabel('Reflectivity');
% %                  title(folderName);
% %                  %Draw a vertical line to show the actual radius
% %                 line([radius radius], ylim, 'Color', 'r', 'LineWidth', 2);
% %                 saveas(figure(3),fullfile(strcat('/Users/saadiagabriel/Desktop/plots/LowestSweep/',folderName), 'Gauss1Fit'),'jpeg');
%     
%    end 
    %saveas(figure(2),fullfile(strcat('/Users/saadiagabriel/Desktop/plots/LowestSweep/',folderName), 'figure 2'),'jpeg');
    % Sanity check. Scatter-plot selected pulse volumes using their x
    % and y coordinates to see what the roost looks like. Use reflectivity
    % to color the pulse volumes for the effect of an image.
    %figure(4);
    %size = 250;
    %scatter(X(inds), Y(inds), size, DZ(inds), 'filled');
    %saveas(figure(3),fullfile(strcat('/Users/saadiagabriel/Desktop/plots/LowestSweep/',folderName), 'figure 3'),'jpeg');
    %only if automatically generating figures
    %close all;
    %variance(variance == 0) = var(Z(inds),'omitnan');
    
    %wait for user input
%     fprintf('Paused. Press any key to continue\n');
   
     %pause;
     
    
end

roosts = roosts(dzPoints > 200);
save('dzRoost.mat','dzPoints','roosts');
%variance