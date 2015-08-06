%load('roostdev.mat');
%load('roostdev_smoothed.mat');
%load('roostdev_smoothed2.mat');
%load('roostdev_withCutoff.mat');
%load('roostdevSum.mat');
load('roostdevSum_withCutoff.mat');

figure(1);
% r = r(s < 1.7E4);
% s = s(s < 1.7E4);
r = r(s < 3.5E4);
s = s(s < 3.5E4);
%r = r(m > -3.5E4);
%m = m(m > -3.5E4);

%**************%
%finding 'r^2'
p = polyfit(r,s,1);
%p(1) is the slope and p(2) is the intercept of the linear predictor. You can also obtain regression coefficients using the Basic Fitting UI.
%Call polyval to use p to predict y, calling the result yfit:
yfit = polyval(p,r);
%Compute the residual values as a vector of signed numbers:
yresid = s - yfit;
%Square the residuals and total them to obtain the residual sum of squares:
SSresid = sum(yresid.^2);
%Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:
SStotal = (length(s)-1) * var(s);
%Compute R2
rsq = 1 - SSresid/SStotal;

plot(r,s, 'Marker', 'x', 'LineStyle', 'none');
%plot(r,m, 'Marker', 'x', 'LineStyle', 'none');
xlabel('Roost Radius');
ylabel('Reflectivity Standard Deviation from Gaussian curves');
title('Reflectivity Standard Deviation Vs. Roost Radius');
hold on;
plot(r,yfit,'r-.');

