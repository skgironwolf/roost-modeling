%this function gets a roost, the radar that captured the roost and the
%reflectivity of the roost 
function [ roo,radar,DZ] = getRoost(scani,seqi)

label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');

%search roosts using scan id and sequence id  
roo = roosts([roosts.scan_id] == scani);
roo = roo([roo.sequence_id] == seqi);
dataRoot = '/Users/saadiagabriel/Desktop';
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        roo.station, roo.year, roo.month, roo.day, roo.filename);
radar = rsl2mat(fileName, roo.station);

%get sweep and reflectivity 
sweep = radar.dz.sweeps(1);
DZ = sweep.data;
FLAG_START = 131067;
DZ(DZ > FLAG_START) = nan;
    
end