%function that models velocity and radial velocity based on roost center,
%x,y locations of pulse volumes, wind velocity components, and bird speed
function [W,U,V,vr] = velocity_modeling(x0,y0,X,Y,uwind,vwind,bspeed)

%angles of pulse volumes from roost center
Theta = cart2pol(X-x0,Y-y0);
%angles of pulse volumes from radar station (origin)
Phi = cart2pol(X,Y);
%bird velocity components
ubird = bspeed*cos(Theta); 
vbird = bspeed*sin(Theta); 
%velocity components
U = ubird+uwind;
V = vwind+vbird; 
%velocity
W = cat(3, U, V);
%radial velocity
vr = U.*cos(Phi)+V.*sin(Phi);

end

%Ignore this note
% ([-vbird,ubird]./sqrt((-vbird).^2+(ubird).^2)).*windspeed;