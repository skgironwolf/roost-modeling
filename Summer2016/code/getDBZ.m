function [ dbZ_predicted ] = getDBZ( X,Y,x0,y0,radius,a )

% standard deviation is a function of radius (use regression function here)
sigma    = 0.38*radius - 5.8e+02;

% find distance of every grid point to center of circle
D = sqrt((X-x0).^2 + (Y - y0).^2);

% Set intensity for selected indices using Gaussian function of distance
% from center of roost
dbZ_predicted = pow2db(abs(a) * exp(-((D-radius)/sigma)^2));

if(dbZ_predicted == -Inf)
    dbZ_predicted = -10; %arbitrarily small value 
end

end

