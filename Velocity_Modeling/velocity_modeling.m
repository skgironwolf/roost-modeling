% birds: ~7 m/s
% wind: 0-10 m/s
% 
% Here?s how to set the color scale for radial velocity:
% 
% imagesc(x, y, z);
% colormap(vrmap2(32));

function [W,U,V,vr] = velocity_modeling(x0,y0,x,y,windspeed,bspeed)

theta = cart2pol(x-x0,y-y0);
phi = cart2pol(x,y);
ubird = bspeed*cos(theta); %i
vbird = bspeed*sin(theta); %j
% Wbird = [ubird,vbird]; 
% Wwind =  %use perpendicular unit vector to find wind direction, multiply by wind speed
uwind = 1/sqrt(2)*windspeed;
vwind = 1/sqrt(2)*windspeed;
U = ubird+uwind;
V = vwind+vbird; 
W = [U,V];
vr = U*cos(phi)+V*sin(phi);

end

% ([-vbird,ubird]./sqrt((-vbird).^2+(ubird).^2)).*windspeed;