load('testA11_unfiltered.mat');
mins = mins(:,1);
scan = ids(:,1);
scan = scan(scan ~= 0);
seq = ids(:,2); 
X_cord = params(:,1);
Y_cord = params(:,2);
R = params(:,3);
X_cord = X_cord(seq ~= 0);
Y_cord = Y_cord(seq ~= 0);
R = R(seq ~= 0);
seq = seq(seq ~= 0);

jaccardIndex = zeros(size(seq,1),2);
%idea 1 
for i=1:size(seq)
%%%%Calculate Jaccard Index%%%%%
% %|A|
% label_area = pi*roo.r^2;
% %|B|
% model_area = pi*R(i)^2;
%|A ? B|
[roo, radar, unused] = getRoost(scan(i),seq(i));
CX = [X_cord(i) roo.x];
CY = [Y_cord(i) roo.y];
CR = [R(i) roo.r];
M = area_intersect_circle_analytical(CX,CY,CR);
model_area = M(1,1);
label_area = M(2,2);
I = M(1,2);
J = I/(label_area + model_area - I);
jaccardIndex(i,1) = J;
jaccardIndex(i,2) = i;

%%%SHOW%%%%
[x,y,Z] = getDisplay(radar);
VR = getVR(radar);
%get coordinate matrices (600x600)
[Y, X] = ndgrid(y,x);
%zf (zoom factor) is the amount of zoom in or out 
%border2 controls the limits of the display windows, based on the zoom
%factor (zf)
%display window limits
vrlim = [-15 15];
figure(1);
imagesc(x,y,VR, vrlim);
colormap(vrmap2(32)); 
% xlim(xlimit);
% ylim(ylimit);
hold on;
th = 0:pi/50:2*pi;
xu = roo.r * cos(th) + roo.x;
yu = roo.r * sin(th) + roo.y;
xunit = R(i) * cos(th) + X_cord(i);
yunit = R(i) * sin(th) + Y_cord(i);
plot(xu,yu,'LineWidth', 3,'color', 'white'); 
plot(xunit, yunit,'LineWidth', 5,'color', 'red');
% pause;
end
av = mean(jaccardIndex(:,1))
med = median(jaccardIndex(:,1))
variance = var(jaccardIndex(:,1))
save('jaccardIndex_testA11','jaccardIndex','av','med','variance');

%(i,j)

% %idea 2 
% for i=1:size(seq,1)
% roo = getRoost(scan(i),seq(i)); 
% dataRoot = '/Users/saadia/Desktop';
% fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
%         roo.station, roo.year, roo.month, roo.day, roo.filename);
% radar = rsl2mat(fileName, roo.station); 
% [x,y,Z] = getDisplay(radar);
% x0 = min(x);
% y0 = min(y);
% dx = mean(abs(diff(x)));   % meters per pixel
% dy = mean(abs(diff(y)));   % meters per pixel
% roost_x = round((roo.x - x0)/dx) + 1; %roost_i = round((roo.x - x0)/dx) + 1;
% roost_y = round((max(y)-roo.y)/dy) + 1; %roost_j = round((roo.y - y0)/dy) + 1;
% roost_r = round(roo.r / dx);
% 
% model_x = round((X(i) - x0)/dx) + 1; %roost_i = round((roo.x - x0)/dx) + 1;
% model_y = round((max(y)-Y(i))/dy) + 1; %roost_j = round((roo.y - y0)/dy) + 1;
% model_r = round(R(i) / dx);
% 
% %|A|
% label_area = pi*roost_r^2;
% %|B|
% model_area = pi*model_r^2;
% %|A ? B|
% Cx = [model_x roost_x];
% Cy = [model_y roost_y];
% Cr = [model_r roost_r];
% M = area_intersect_circle_analytical(Cx,Cy,Cr);
% M = sum(M(:));
% J = M/(label_area + model_area - M);
% if(label_area + model_area == M)
% J = 1;
% end
% jaccardIndex(i,1) = J;
% end