function [ dbZ_predicted ] = getDBZ_vec( X,Y,x0,y0,radius,a )

% standard deviation is a function of radius (use regression function here)
sigma    = 0.38*radius - 5.8e+02;

% find distance of every grid point to center of circle
D = sqrt((X-x0).^2 + (Y - y0).^2);

% Set intensity for selected indices using Gaussian function of distance
% from center of roost
dbZ_predicted = pow2db(abs(a) * exp(-((D-radius)/sigma).^2));
dbZ_predicted(dbZ_predicted == -Inf) = -10;
end