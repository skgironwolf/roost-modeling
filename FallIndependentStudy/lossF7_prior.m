%first working version of loss function
function [ lossVR ] = lossF7_prior( theta,X2,Y2,vr,uwind,vwind)
tic
%load('Probability.mat');
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Y2 = Y2(~isnan(vr));
X2 = X2(~isnan(vr));
vr = vr(~isnan(vr));

errorVR = 0;

rrv = zeros(size(X2,1),size(X2,1));

%one by one, get the predicted and actual reflectivity for each pulse
%volume in the bounding area around the roost and find the average sum of the squared
%loss 
for i=1:size(X2)
  
  x_cord = X2(i);
  y_cord = Y2(i);
  [W,U,V,vR_predicted] = getVelocity(theta(1),theta(2), x_cord,y_cord,uwind,vwind,theta(5));
  rrv(i,1) = vR_predicted;
  vR_actual = vr(i);
  rrv(i,2) = vR_actual;
   errorVR = errorVR + (vR_actual - vR_predicted)^2+getBirdP(theta(5))+getWindP(sqrt(uwind^2+vwind^2));
  %errorVR = errorVR + (vR_actual - vR_predicted)^2+getP(birdCurve(theta(5)))+getP(windCurve(sqrt(uwind^2+vwind^2)));
end
lossVR = errorVR/size(X2,1);
toc
end