function [ loss ] = lossF5( theta,X2,Y2,Z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


error = 0;
DIST_FROM_ROOST = sqrt((X2-theta(1)).^2 + (Y2-theta(2)).^2);
subs = createSubs2(Z,DIST_FROM_ROOST,500);
Z = Z(subs ~= 0);
DIST_FROM_ROOST = DIST_FROM_ROOST(subs ~= 0);
subs = subs(subs ~= 0);
Z_average = accumarray(subs,Z,[],@mean);
Z_average = Z_average(Z_average ~= 0);
DFC = accumarray(subs,DIST_FROM_ROOST,[],@median);
DFC = DFC(DFC ~= 0);
c = sqrt(2*(sqrt(2*pi)/theta(4))^2);

%one by one, get the predicted and actual reflectivity for each pulse
%volume in the bounding area around the roost and find the average sum of the squared
%loss 
for i=1:size(DFC)
  
  Z_predicted = theta(4)*exp(-((DFC(i)-theta(3))/c)^2);
  Z_actual = Z_average(i);
  error = error + (Z_actual - Z_predicted)^2; 
%   s = sqrt(theta(1)^2-2*X2(i)*theta(1)-theta(2)^2+Y2(i)+X2(i)^2);
%   s2 = sqrt(-theta(2)^2+theta(1)^2-2*X2(i)*theta(1)+Y2(i)+X2(i)^2);
%   grad1 = (a*(theta(1)-X2(i))*exp((-s+r)/gaussC.c1^2))/gaussC.c1^2*s;
%   grad2 = (a*theta(2)*exp((-s2+r)/gaussC.c1^2))/gaussC.c1^2*s2;
%   s = (X2(i)-2*X2(i)*theta(1)+theta(1)^2)^2+(Y2(i)-2*Y2(i)*theta(2)+theta(2)^2)^2;
%   ep = (-sqrt(s)-r)/gaussC.c1^2;
%   grad1 = grad1+2*(-a*exp(ep))*-a*exp(ep)*(-.5*(s^-.5)/gaussC.c1^2)*2*(X2(i)^2-2*X2(i)*theta(1)+theta(1)^2)*(2*X2(i)+2*theta(1));
%   grad2 = grad2+2*(-a*exp(ep))*-a*exp(ep)*(-.5*(s^-.5)/gaussC.c1^2)*2*(Y2(i)^2-2*Y2(i)*theta(2)+theta(2)^2)*(2*Y2(i)+2*theta(2));

% s = X2(i)-2*X2(i)*theta(1)+theta(1)^2+Y2(i)-2*Y2(i)*theta(2)+theta(2)^2;
% ep = (-sqrt(s)-r)/gaussC.c1^2;
% grad1 = 2*((Z_actual-a*exp(ep))*(-a*exp(ep)*((.5*s^-.5)/gaussC.c1^2)*(-2*X2(i)+2*theta(1))));
% grad2 = 2*((Z_actual-a*exp(ep))*(-a*exp(ep)*((.5*s^-.5)/gaussC.c1^2)*(-2*Y2(i)+2*theta(2))));




end

% t = [theta(1),theta(2),r,a];
% g = zeros(2,1);
% g(1) = grad1/size(DFC,1);
% g(2) = grad2/size(DFC,1);
 loss = error/size(DFC,1); 
% save('theta','t');

end