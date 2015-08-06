step = 500;
range = 100000;

% x and y grid coordinates
x = (step:step:range)';
y = (step:step:range)';
[X, Y] = meshgrid(x, y);

% data matrix: initialize to zeros
Z = zeros(size(X));

% parameters of a roost
x0       = 50000;
y0       = 40000;
a        = 0.5;
r        = 10000;

% standard deviation is a function of radius (use regression function here)
sigma    = 0.38*r - 5.8e+02;

% find distance of every grid point to center of circle
D = sqrt((X-x0).^2 + (Y - y0).^2);

% Select indices of grid points that are within 3 standard deviations
% from the perimeter of the circle
inds =  D >= r-3*sigma & D <= r + 3*sigma;
fprintf(size(inds));

% Set intensity for selected indices using Gaussian function of distance
% from center of roost
Z(inds) = a * exp(-((D(inds)-r)./sigma).^2);
Z(inds) = abs(pow2db(Z(inds)));
% Display with color scale that goes from 0 to 1
imagesc(x, y, Z, [0 1]);
colorbar;
