function [ loss ] = lossF2( theta,X2,Y2,dbZ)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

error = 0;

rv = zeros(size(X2,1),size(X2,1));

%one by one, get the predicted and actual reflectivity for each pulse
%volume in the bounding area around the roost and find the average sum of the squared
%loss 
for i=1:size(X2)
  
  x_cord = X2(i);
  y_cord = Y2(i);
  dBZ_predicted = getDBZ(x_cord,y_cord,theta(1),theta(2),theta(3),theta(4));
  rv(i,1) = dBZ_predicted;
  dBZ_actual = dbZ(i);
  rv(i,2) = dBZ_actual;
  error = error + (dBZ_actual - dBZ_predicted)^2; 
  
end

loss = error/size(X2,1);

%save predicted and actual reflectivity values for each pulse volume
c = rv(1:end,1);
d = rv(1:end,2);
c = c(d ~= 0);
d = d(d ~= 0);
rv = [c,d];
save('errorfile','rv');



end


