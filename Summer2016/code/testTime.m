label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');

theRoost = roosts(20);

%get data root 
dataRoot = '/Users/saadiagabriel/Desktop';
%get file name 
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        theRoost.station, theRoost.year, theRoost.month, theRoost.day, theRoost.filename);
%get radar 
radar = rsl2mat(fileName, theRoost.station);

[x,y,DZ] = getDisplay(radar);
VR = getVR(radar );
[Y, X] = ndgrid(y,x);

x0 = theRoost.x;
y0 = theRoost.y;
radius = theRoost.r;

border2 = X < (x0+(radius+(radius/2))) & X > (x0-(radius+(radius/2))) & Y < y0+(radius+(radius/2)) & Y > y0-(radius+(radius/2));
 vr = VR(border2);
 dbZ = DZ(border2);
 Y = Y(border2);
 X = X(border2);
theta1 = [0,0,0,0];
theta2 = [0,0,0,0,6.8];
[uwind,vwind] = windshift(theRoost,theRoost.scan_id,theRoost.sequence_id,5);

lossF7(theta1,X,Y,vr,uwind,vwind,6.8);
lossF7_prior(theta2,X,Y,vr,uwind,vwind);
