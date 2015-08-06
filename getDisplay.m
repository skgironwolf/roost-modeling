%function to get x,y vectors and Z 
function [ x,y,Z] = getDisplay(radar)
    
    rmax = 150000; % 150km
    dim  = 600;    % 600 pixels
    
    %radar data (reflectivity) 
    sweep = radar.dz.sweeps(1);
    
    % convert to cartesian
    [Z, x, y] = sweep2cart(sweep, rmax, dim);     


end

%Ignore for now
    %get X,Y coordinates just for bounding box around roost 
    %(X2,Y2)
    %use bounding box to create x,y limits for display window
    %(xlimit,ylimit)
    %get x values and y values for roost label circle 
    %(xu,yu)
%     [RANGE, AZ] = ndgrid(range, az);
%     THETA = cmp2pol(AZ);
%     [X2, Y2] = pol2cart(THETA, RANGE);    
%get azimuth and range from sweep 
%    [az, range] = get_az_range(sweep);