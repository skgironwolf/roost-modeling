
%first working version of loss function
function [ loss ] = lossF9( theta,X2,Y2,dbZ,vr,uwind,vwind)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
YZ = Y2(~isnan(dbZ));
XZ = X2(~isnan(dbZ));
YV = Y2(~isnan(vr));
XV = X2(~isnan(vr));
dbZ = dbZ(~isnan(dbZ));
vr = vr(~isnan(vr));



errorZ = 0;
errorVR = 0;

rrv = zeros(size(X2,1),size(X2,1));
rv = zeros(size(X2,1),size(X2,1));

%one by one, get the predicted and actual reflectivity for each pulse
%volume in the bounding area around the roost and find the average sum of the squared
%loss 
for i=1:size(XZ)
  
  x_cord = XZ(i);
  y_cord = YZ(i);
  dBZ_predicted = getDBZ(x_cord,y_cord,theta(1),theta(2),theta(3),theta(4));
  rv(i,1) = dBZ_predicted;
  dBZ_actual = dbZ(i);
  rv(i,2) = dBZ_actual;
  errorZ = errorZ + (dBZ_actual - dBZ_predicted)^2+getBirdP(theta(5))+getWindP(sqrt(uwind^2+vwind^2));
  
end

for i=1:size(XV)
  
  x_cord = XV(i);
  y_cord = YV(i);
  [W,U,V,vR_predicted] = getVelocity(theta(1),theta(2), x_cord,y_cord,uwind,vwind,theta(5));
  rrv(i,1) = vR_predicted;
  vR_actual = vr(i);
  rrv(i,2) = vR_actual;
  errorVR = errorVR + (vR_actual - vR_predicted)^2+getBirdP(theta(5))+getWindP(sqrt(uwind^2+vwind^2));
end

loss = (errorVR+errorZ)/size(X2,1);


% %save predicted and actual reflectivity values for each pulse volume
% c = rv(1:end,1);
% d = rv(1:end,2);
% c = c(d ~= 0);
% d = d(d ~= 0);
% rv = [c,d];
% save('errorfile','rv');



end


