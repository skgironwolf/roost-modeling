function [x,y,Z] = genRoost(x0,y0,radius,a)

%step = 500;
range = 150000;
dim = 600; 

% x and y grid coordinates
x = linspace(-range,range,dim);
y = linspace(-range,range,dim);
% x = (step:step:range)';
% y = (step:step:range)';
[X, Y] = meshgrid(x, y);

% data matrix: initialize to zeros
Z = zeros(size(X));

% standard deviation is a function of radius (use regression function here)
sigma    = 0.38*radius - 5.8e+02;

% find distance of every grid point to center of circle
D = sqrt((X-x0).^2 + (Y - y0).^2);

% Select indices of grid points that are within 3 standard deviations
% from the perimeter of the circle
inds =  D >= radius-3*sigma & D <= radius + 3*sigma;

% Set intensity for selected indices using Gaussian function of distance
% from center of roost
Z(inds) = a * exp(-((D(inds)-radius)./sigma).^2);


% border = X < (x0+(radius+(radius/2))) & X > (x0-(radius+(radius/2))) & Y < y0+(radius+(radius/2)) & Y > y0-(radius+(radius/2));
% Z = Z(border);
% x = x(border);
% y = y(border);
% save('dimensions2','Z','x','y');

% border = X < (x0+(radius+(radius/2))) & X > (x0-(radius+(radius/2))) & Y < y0+(radius+(radius/2)) & Y > y0-(radius+(radius/2));
% Z_bounded = Z(border);
% Z(border) = 1;
%Zdb = pow2db(Z_bounded);
    
% %UNTITLED3 Summary of this function goes here
% %   Detailed explanation goes here
% step = 500;
% range = 100000;
% 
% % x and y grid coordinates
% x = (step:step:range)';
% y = (step:step:range)';
% [X, Y] = meshgrid(x, y);
% 
% % data matrix: initialize to zeros
% Z = zeros(size(X));
% 
% for i=1:(radius/1000)
%     r        = 1000*i;
%     sigma    = 0.3*r; %0.38*r - 5.8e+02; 
% 
%     % find distance of every grid point to center of circle
%     D = sqrt((X-x0).^2 + (Y - y0).^2);
% 
%     % Select indices of grid points that are within penwidth/2 from the 
%     % perimeter of the circle 
%     inds =  D >= r-3*sigma & D <= r + 3*sigma;
% 
%     % Set data to 1 for those pixels
%     Z(inds) = a * normpdf(D(inds), r, sigma);
%     
%     imagesc(x, y, db(Z), [0 10] );
%     colorbar;
%     pause(.5);
% end


end

