

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

for i=1:nRoosts
    
    theRoost = roosts(i);
    
    fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        theRoost.station, theRoost.year, theRoost.month, theRoost.day, theRoost.filename);
        
    fprintf(fileName);
   
    radar = rsl2mat(fileName, theRoost.station);
    
    
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
    inds = DIST_FROM_ROOST <= 1.75*radius;
    inds = inds & ELEV <= 1;  % first elevation angle only  
    M = Z(inds);
    N = DIST_FROM_ROOST(inds);
    N = N(~isnan(M));
    M = M(~isnan(M));
    
    subs = createSubs2(M,N,500);
    AR = accumarray(subs,M,[],@mean);
    AR = AR(AR ~= 0);
    DTC = accumarray(subs,N,[],@median);
    DTC = DTC(DTC ~= 0);
pause;
    
end