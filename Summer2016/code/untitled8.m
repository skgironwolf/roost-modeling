label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
nRoosts = numel(roosts); % number of roosts

%mins stores loss function fmincon local mins 
mins = zeros(nRoosts);
params = zeros(nRoosts,4);
ids = zeros(nRoosts,2);

%go through roosts and run through loss function (lf), then minimize lf
for i=1:nRoosts

%get ith roost     
theRoost = roosts(i);
theRoost.scan_id
theRoost.sequence_id 
%get data root 
dataRoot = '/Users/saadia/Desktop';
%get file name 
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        theRoost.station, theRoost.year, theRoost.month, theRoost.day, theRoost.filename);
%get radar 
radar = rsl2mat(fileName, theRoost.station);

[x,y,DZ] = getDisplay(radar);
VR = getVR(radar );
[Y, X] = ndgrid(y,x);

%set azimuth angle, range and max radius 
%  AZ_RES    = 0.5;
%  RANGE_RES = 250;
%  RMAX_M    = 150000;
% 
%  %choose all data or lowest sweep 
%  
%     %    whichdata = 'all';
%     whichdata = 'lowest-sweep';
%     
%     switch whichdata
%         case 'all'
%             radar_aligned = align_scan(radar, AZ_RES, RANGE_RES, RMAX_M );
%             [data, range, az, elev] = radar2mat(radar_aligned, {'dz', 'vr'});
%             DZ = data{1};
%             VR = data{2};
%         case 'lowest-sweep'
%             sweep = radar.dz.sweeps(1);
%             sweepVR = radar.vr.sweeps(1);
%             DZ = sweep.data;
%             VR = sweep.data;
%             FLAG_START = 131067;
%             DZ(DZ > FLAG_START) = nan;
%             VR(VR > FLAG_START) = nan;
%             [az, range] = get_az_range(sweep);
%             elev = sweep.elev;
%     end  
% 
% %get polar coordinates 
% [RANGE, AZ, ELEV] = ndgrid(range, az, elev);
% [GROUND_RANGE, HEIGHT] = slant2ground(RANGE, ELEV);
% THETA = cmp2pol(AZ);
% %convert to cartesian 
% [XZ, YZ] = pol2cart(THETA, RANGE);

%set up for-loop to run through set of 24 hand-picked roost scans 
% if(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/17/KDOX20111017_114400_V04.gz')&&(theRoost.sequence_id == 1669))...
%         ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/11/KDOX20111011_110827_V04.gz')&&(theRoost.sequence_id == 1658))...  
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/11/KDOX20111011_110242_V04.gz')&&(theRoost.sequence_id == 1658))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/10/KDOX20111010_110053_V04.gz')&&(theRoost.sequence_id == 6312))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/10/KDOX20111010_111224_V04.gz')&&(theRoost.sequence_id == 1657))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/10/KDOX20111010_110639_V04.gz')&&(theRoost.sequence_id == 1657))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_111712_V04.gz')&&(theRoost.sequence_id == 1668))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_111125_V04.gz')&&(theRoost.sequence_id == 1668))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_110539_V04.gz')&&(theRoost.sequence_id == 1668))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_105953_V04.gz')&&(theRoost.sequence_id == 1668))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_111125_V04.gz')&&(theRoost.sequence_id == 1667))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_110539_V04.gz')&&(theRoost.sequence_id == 1667))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/08/KDOX20111008_111423_V04.gz')&&(theRoost.sequence_id == 1665))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/08/KDOX20111008_110441_V04.gz')&&(theRoost.sequence_id == 1655))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/08/KDOX20111008_113347_V04.gz')&&(theRoost.sequence_id == 1653))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/08/KDOX20111008_110441_V04.gz')&&(theRoost.sequence_id == 1652))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/05/KDOX20111005_110150_V04.gz')&&(theRoost.sequence_id == 1631))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/25/KDOX20111025_114309_V04.gz')&&(theRoost.sequence_id == 6322))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/22/KDOX20111022_113038_V04.gz')&&(theRoost.sequence_id == 6317))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/05/KDOX20111005_111131_V04.gz')&&(theRoost.sequence_id == 1624))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_110835_V04.gz')&&(theRoost.sequence_id == 1634))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_110835_V04.gz')&&(theRoost.sequence_id == 1640))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/25/KDOX20111025_113327_V04.gz')&&(theRoost.sequence_id == 6322))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/05/KDOX20111005_110150_V04.gz')&&(theRoost.sequence_id == 1625))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/07/KDOX20111007_111205_V04.gz')&&(theRoost.sequence_id == 1643))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_110835_V04.gz')&&(theRoost.sequence_id == 1634))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/25/KDOX20111025_114309_V04.gz')&&(theRoost.sequence_id == 6322))...
%             ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/25/KDOX20111025_113327_V04.gz')&&(theRoost.sequence_id == 6322))...
 
%11 circular roosts 
if(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/11/KDOX20111011_110827_V04.gz')&&(theRoost.sequence_id == 1658))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_110539_V04.gz')&&(theRoost.sequence_id == 1668))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/09/KDOX20111009_111125_V04.gz')&&(theRoost.sequence_id == 1667))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_112328_V04.gz')&&(theRoost.sequence_id == 1575))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_105852_V04.gz')&&(theRoost.sequence_id == 1636))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_110835_V04.gz')&&(theRoost.sequence_id == 1640))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_110835_V04.gz')&&(theRoost.sequence_id == 1634))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_110835_V04.gz')&&(theRoost.sequence_id == 1640))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_105852_V04.gz')&&(theRoost.sequence_id == 1634))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_110027_V04.gz')&&(theRoost.sequence_id == 1575))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_110027_V04.gz')&&(theRoost.sequence_id == 1575))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/07/KDOX20111007_110223_V04.gz')&&(theRoost.sequence_id == 1643))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_111157_V04.gz')&&(theRoost.sequence_id == 1575))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_110027_V04.gz')&&(theRoost.sequence_id == 1579))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_110612_V04.gz')&&(theRoost.sequence_id == 1575))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/01/KDOX20111001_110612_V04.gz')&&(theRoost.sequence_id == 1575))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_105852_V04.gz')&&(theRoost.sequence_id == 1639))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/06/KDOX20111006_105852_V04.gz')&&(theRoost.sequence_id == 1637))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/05/KDOX20111005_111131_V04.gz')&&(theRoost.sequence_id == 1633))...
        ||(strcmp(fileName,'/Users/saadiagabriel/Desktop/KDOX/2011/10/05/KDOX20111005_111131_V04.gz')&&(theRoost.sequence_id == 1633))
        %11        

%get x,y,r parameters 
x0 = theRoost.x;
theRoost.x
y0 = theRoost.y;
theRoost.y
radius = theRoost.r;
theRoost.r

%set up constraints to get pulse volumes within a bounding box that scales to the size
%of the roost radius 
border2 = X < (x0+(radius+(radius/2))) & X > (x0-(radius+(radius/2))) & Y < y0+(radius+(radius/2)) & Y > y0-(radius+(radius/2));

%get reflectivity in decibels and X,Y coordinates for pulse volumes within
%bounding box (remove NaN reflectivity values and corresponding
%coordinates) 
 vr = VR(border2);
 dbZ = DZ(border2);
 Y = Y(border2);
 X = X(border2);

 %set upper and lower bound limits for fmincon parameters, with cases for
 %negative x,y parameter values 
border2 = X < (x0+(radius*2)) & X > (x0-(radius*2)) & Y < y0+(radius*2) & Y > y0-(radius*2);
lb = [min(X(border2)),min(Y(border2)),500,0,0];
ub = [max(X(border2)),max(Y(border2)),36000,2000,20];%change a's upper limit to 35 from 100

% lb = [.5*x0,y0*.5,radius*.5,0]; %changed from .5*x0
% ub = [2*x0,y0*2,radius*2,1000]; %changed from 2*y0
% 
% if(x0 < 0)
% lb(1) = x0*2;
% ub(1) = x0*.5;
% end
% if(y0 < 0) 
% lb(2) = x0*2;
% ub(2) = y0*.5;
% end

%just some code I was trying out, ignore 
% A = [0 0 0 -1;0 0 1 0; 0 0 -1 0; 0 1 0 0; 1 0 0 0; 0 -1 0 0; -1 0 0 0];
% b = [0;radius*2;0;y0+y0*.5;x0+x0*.5;-y0+y0*.5;-x0+x0*.5];
% rx = rand*80000*(x0/abs(x0))
% ry = rand*80000*(y0/abs(y0))
% rr = rand*40000
% ra = rand*10
theta = [0,0,0,0,6.8];
%find a feasible point (a point within constraints) 
f = zeros(size(theta)); 
theta = linprog(f,[],[],[],[],lb,ub);
theta(3) = theta(3); %+6,000 is very good
[uwind,vwind] = windshift(theRoost,theRoost.scan_id,theRoost.sequence_id,5);
%set fmincon options and create anonymous function 
options = optimoptions('fmincon','Display','iter','MaxFunEvals',15000,'TolX',1e-21);
lf = @(theta)lossF9(theta,X,Y,dbZ,vr,uwind,vwind);

%this was just for testing 
%save('roostDB','dbZ','DZ','theRoost','X2','Y2');

%find min and store 
% m = fmincon(lf,theta,[],[],[],[],lb,ub,[],options);
% m = fmincon(lf,m,[],[],[],[],lb,ub,[],options);
m = fmincon(lf,theta,[],[],[],[],lb,ub,[],options);

mins(i) = lf(m); 
ids(i,1) = theRoost.scan_id;
ids(i,2) = theRoost.sequence_id;
params(i,1) = m(1); 
params(i,2) = m(2); 
params(i,3) = m(3); 
params(i,4) = m(4);  
m(5)
% pause; 

%min = fminunc(@practiceFun,x)
%practiceFun(min)
end

end

% p = zeros(24,4);
% IDS = zeros(24,2);
p = zeros(16,4);
IDS = zeros(16,2);
%remove 0 min values and save mins 
mins = mins(mins ~= 0);

%use logical indexing to set up parameter and ID matrices 
column = params(1:end,1);
col = ids(1:end,1);
p(1:end,1) = column(column ~= 0); 
IDS(1:end,1) = col(col ~= 0);
column = params(1:end,2);
col = ids(1:end,2);
p(1:end,2) = column(column ~= 0);
IDS(1:end,2) = col(col ~= 0);
column = params(1:end,3);
p(1:end,3) = column(column ~= 0);
column = params(1:end,4);
p(1:end,4) = column(column ~= 0);

save('minError_expandBorder','mins','p','IDS');