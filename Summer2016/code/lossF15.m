
function [ loss ] = lossF15( theta,X2,Y2,dbZ,vr,uwind,vwind)
%Loss function with radial velocity, reflectivity, and priors
%X and Y coordinates for radial velocity / reflectivity (consider filtering
%out pixels that are nan for either from both) 
YZ = Y2(~isnan(dbZ));
XZ = X2(~isnan(dbZ));
YV = Y2(~isnan(vr));
XV = X2(~isnan(vr));
%reflectivity values of pixels
dbZ = dbZ(~isnan(dbZ));
%radial velocity values of pixels
vr = vr(~isnan(vr));

%rrv = zeros(size(X2,1), 2);
%rv = zeros(size(X2,1),  2);

%one by one, get the predicted and actual reflectivity for each pulse
%volume in the bounding area around the roost and find the average sum of the squared
%loss

%%Vectorized Approach 

%get predicted reflectivity
dBZ_predicted = getDBZ_vec(XZ,YZ,theta(1),theta(2),theta(3),theta(4));
%get prior for bird and wind speed
prior = getBirdP(theta(5)) + getWindP(sqrt(uwind^2+vwind^2));
%get reflectivity error 
M1 = (dbZ - dBZ_predicted).^2 + prior;
errorZ = sum(M1(:));
%get predicted radial velocity
[W,U,V,vR_predicted] = getVelocity(theta(1),theta(2),XV,YV,uwind,vwind,theta(5));
%get radial velocity error 
M2 = (vr - vR_predicted).^2 + prior;
errorVR = sum(M2(:));
%calculate loss 
loss = (errorVR+errorZ) / max(size(X2));

end
