%%%% Use this version of jaccard (ignore jaccard2) %%%%
%%%% Provided a .mat file containing data (scan ids, sequence ids, and parameters) from one of the loss function
%%%% tests, this program calculates the jaccardIndex using the intersection of the actual and
%%%% predicted roost areas 

load('testA9_unfiltered.mat');

%%%% filter arrays for empty entries 
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

%%% Calculate Jaccard Index for each roost 
for i=1:size(seq)
[roo, radar, unused] = getRoost(scan(i),seq(i)); % get actual roost data 
CX = [X_cord(i) roo.x]; % get model and actual x coordinates
CY = [Y_cord(i) roo.y]; % get model and actual y coordinates
CR = [R(i) roo.r]; % get model and actual radius 
M = area_intersect_circle_analytical(CX,CY,CR); % calculate area of intersection between model and actual roost 
model_area = M(1,1); %|A|
label_area = M(2,2); %|B|
I = M(1,2); %| A ? B |
J = I/(label_area + model_area - I); % | A ? B | / ( |A| + |B| - | A ? B | ) 
jaccardIndex(i,1) = J; % store the Jaccard Index 
jaccardIndex(i,2) = i; % store the # of the roost 

%%% Show Model and Predicted Labels %%%%
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

%print average of jaccard indices 
av = mean(jaccardIndex(:,1))
% print median of jaccard indices 
med = median(jaccardIndex(:,1))
% print variance of jaccard indices 
variance = var(jaccardIndex(:,1))
%save results 
save('jaccardIndex_testA9','jaccardIndex','av','med','variance');

%%%%% IGNORE AFTER THIS POINT %%%%%

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