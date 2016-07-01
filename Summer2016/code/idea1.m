%%%%% Experimention (IGNORE) %%%%%
label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
nRoosts = numel(roosts); % number of roosts
data = zeros(nRoosts,2);

tic 
for i=1:nRoosts

%get ith roost     
roo = roosts(i);
roo.scan_id 
roo.sequence_id 
%get data root 
dataRoot = '/Users/saadia/Desktop';
%get file name 
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        roo.station, roo.year, roo.month, roo.day, roo.filename);
%get radar 
radar = rsl2mat(fileName, roo.station);

[x,y,DZ] = getDisplay(radar);
DZ = DZ(~isnan(DZ));
data(i,1) = mean(DZ(:));
data(i,2) = roo.r;

end
toc