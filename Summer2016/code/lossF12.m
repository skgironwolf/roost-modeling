

function [ loss ] = lossF12( theta,X2,Y2,vr,uwind,vwind)
%Loss function with radial velocity 
%X and Y coordinates for radial velocity / reflectivity (consider filtering
%out pixels that are nan for either from both) 
YV = Y2(~isnan(vr));
XV = X2(~isnan(vr));
%radial velocity values of pixels
vr = vr(~isnan(vr));

%%Vectorized Approach 

%get predicted radial velocity
[W,U,V,vR_predicted] = getVelocity(theta(1),theta(2),XV,YV,uwind,vwind,theta(5));
%get radial velocity error 
M2 = (vr - vR_predicted).^2;
errorVR = sum(M2(:));
%calculate loss 
loss = (errorVR) / max(size(X2));

end
