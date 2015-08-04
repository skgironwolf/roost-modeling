%function to get X,Y coordinates of display and window x,y limits 
function [ X,Y,X2,Y2,Z] = getDisplay(radar,roo)
    
    rmax = 150000; % 150km
    dim  = 600;    % 600 pixels
    
    %radar data (reflectivity) 
    sweep = radar.dz.sweeps(1);
    
    % convert to cartesian
    [Z, X, Y] = sweep2cart(sweep, rmax, dim);     
    
    %get azimuth and range from sweep 
   [az, range] = get_az_range(sweep);
    
    
    %get X,Y coordinates just for bounding box around roost 
    %(X2,Y2)
    %use bounding box to create x,y limits for display window
    %(xlimit,ylimit)
    %get x values and y values for roost label circle 
    %(xu,yu)
    [RANGE, AZ] = ndgrid(range, az);
    THETA = cmp2pol(AZ);
    [X2, Y2] = pol2cart(THETA, RANGE); 

end

