label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
nRoosts = numel(roosts); % number of roosts

%mins stores loss function fmincon local mins 
speed = zeros(nRoosts,2);

%go through roosts and run through loss function (lf), then minimize lf
for i=1:nRoosts

%get ith roost     
theRoost = roosts(i);
%get data root 
dataRoot = '/Users/saadiagabriel/Desktop';
%get file name 
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        theRoost.station, theRoost.year, theRoost.month, theRoost.day, theRoost.filename);
%get radar 
radar = rsl2mat(fileName, theRoost.station);

[uwind,vwind] = windshift(theRoost,theRoost.scan_id,theRoost.sequence_id,5);
windspeed = sqrt(uwind^2+vwind^2);
bspeed = birdshift(theRoost,theRoost.scan_id,theRoost.sequence_id);

speed(i,1) = windspeed;
speed(i,2) = bspeed;  
% pause; 

%min = fminunc(@practiceFun,x)
%practiceFun(min)
end

save('speedData','speed');