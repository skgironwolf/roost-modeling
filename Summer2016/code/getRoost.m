function [ roo,radar,DZ ] = getRoost(scani,seqi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
label_file = 'labels-KDOX-2011-2010.csv';
% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');

roo = roosts([roosts.scan_id] == scani);
roo = roo([roo.sequence_id] == seqi);
dataRoot = '/Users/saadia/Desktop';
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        roo.station, roo.year, roo.month, roo.day, roo.filename);
radar = rsl2mat(fileName, roo.station); 

sweep = radar.dz.sweeps(1);
DZ = sweep.data;
FLAG_START = 131067;
DZ(DZ > FLAG_START) = nan;
[az, range] = get_az_range(sweep);

Z  = idb(DZ);
[RANGE, AZ] = ndgrid(range, az);
THETA = cmp2pol(AZ);         
[X2, Y2] = pol2cart(THETA, RANGE);
x0 = roo.x;
y0 = roo.y;
radius = roo.r;
border2 = X2 < (x0+(radius+(radius/2))) & X2 > (x0-(radius+(radius/2))) & Y2 < y0+(radius+(radius/2)) & Y2 > y0-(radius+(radius/2));

X2 = X2(border2);
Y2 = Y2(border2);
Z = Z(border2);
    
end

