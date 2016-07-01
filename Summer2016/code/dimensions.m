
%%%%%%%%%%%%%%%%  Experimentation (Ignore)   %%%%%%%%%%%%%%%%%

%%%Get actual and detected roost data 
label_file = 'testingData.csv';

fileName = 'rects.txt';
lines = textread(fileName,'%s','delimiter','\r'); %#ok<DTXTRD>
numObj = length(lines)-1;
rects_detected = zeros(numObj,4);

roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
roosts = roosts([roosts.scan_id] == str2num(lines{1})); %#ok<*ST2NM>
nRoosts = numel(roosts); % number of roosts

%calculate and save actual and detected roost bounding boxes 
data_actual = [[roosts.x]' [roosts.y]' [roosts.r]' ];
rects_actual = zeros(nRoosts,4);
for i = 2:(numObj + 1)
   %detected bounding boxes 
   rect = str2num(lines{i});
   rects_detected(i-1,1) = rect(1);
   rects_detected(i-1,2) = rect(2);
   rects_detected(i-1,3) = rect(3);
   rects_detected(i-1,4) = rect(4);
   %actual bounding boxes 
   if(i < nRoosts + 1)
       roo = roosts(i-1);
       dataRoot = '/Users/saadia/Desktop';
       fileName = sprintf('%s/%s', dataRoot, roo.filename);
       radar = rsl2mat(fileName, roo.station);
       [x,y,Z] = getDisplay(radar);
       %%more successful attempts at scaling
       %figure(2)
       % im = imagesc(VR);
       % set(gca,'visible','off');
       x0 = min(x);
       y0 = min(y);
       dx = mean(abs(diff(x)));   % meters per pixel
       dy = mean(abs(diff(y)));   % meters per pixel
       %hold on;
       roost_i = round((roo.x - x0)/dx) + 1; %roost_i = round((roo.x - x0)/dx) + 1;
       roost_j = round((max(y)-roo.y)/dy) + 1; %roost_j = round((roo.y - y0)/dy) + 1;
       roost_r = round(roo.r / dx);
       minX = (roost_i-1*roost_r);
       minY = (roost_j-1*roost_r);
       box_d = roost_r*2;
       rects_actual(i-1,1) = minX;
       rects_actual(i-1,2) = minY;
       rects_actual(i-1,3) = box_d;
       rects_actual(i-1,4) = box_d;
      
   end   
end
%calculate Jaccard index for bounding boxes 
intersection = rectint(rects_detected,rects_actual);
[row,col] = find(intersection ~= 0);
results = zeros(numObj,1);
results_actualR = zeros(nRoosts,1);
image = imread('/Users/saadia/Desktop/wsrlib/TestingData/KDOX20090801_100959_V04.png');
imshow(image, []);
for j = 1:size(row,1)
    area_detected = (rects_detected(row(j),3)*rects_detected(row(j),4));
    area_actual = (rects_actual(col(j),3)*rects_actual(col(j),4)); 
    result = intersection(row(j),col(j)) / ((area_detected + area_actual) - intersection(row(j),col(j)));
    results(row(j)) = max(results(row(j)),result);
    results_actualR(col(j)) = max(results(col(j)),result); 
 hold on;
 rectangle('position',[rects_actual(col(j),1) rects_actual(col(j),2) rects_actual(col(j),3) rects_actual(col(j),4)],'edgecolor', 'r');
 hold on;
 rectangle('position',[rects_detected(row(j),1) rects_detected(row(j),2) rects_detected(row(j),3) rects_detected(row(j),4)],'edgecolor', 'y');
end

%measure # of hits , misses, and false detects 
accept_Rate = .4;

hitRate = size(results_actualR(results_actualR > accept_Rate),1) / size(results,1)
missRate = size(results_actualR(results_actualR <= accept_Rate),1) / size(results,1)
hit_miss_ratio = hitRate / missRate
roostsFound = size(results_actualR(results_actualR > accept_Rate),1) / size(results_actualR,1)

resultSTR = cell(size(results_actualR));
resultSTR(:) = {'miss'};
resultSTR(results_actualR >= accept_Rate) = {'hit'};
resultSTR 

falseRate = (size(results,1) - size(results_actualR,1)) / size(results,1); 
if(falseRate < 0)
    falseRate = 0;
end
falseRate 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%% RECTANGLE AREA %%%%%%%
% label_file = 'labels-KDOX-2011-2010.csv';
% 
% % Get struct array with all roosts
% %   Note: second argument gives format specifiers
% %     these are fairly universal. See help sprintf, fprintf
% roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
% maxRadius = max([roosts.r]);
% minRadius = min([roosts.r]);
% dataRoot = '/Users/saadia/Desktop';
% roo = roosts([roosts.r] == maxRadius);
% fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
%         roo.station, roo.year, reIDoo.month, roo.day, roo.filename);
% radar = rsl2mat(fileName, roo.station); 
% [x,y,Z] = getDisplay(radar);
% %%more successful attempts at scaling
% %figure(2)
% % im = imagesc(VR);
% % set(gca,'visible','off');
% x0 = min(x);
% y0 = min(y);
% dx = mean(abs(diff(x)));   % meters per pixel
% dy = mean(abs(diff(y)));   % meters per pixel
% %hold on;
% roost_i = round((roo.x - x0)/dx) + 1; %roost_i = round((roo.x - x0)/dx) + 1;
% roost_j = round((max(y)-roo.y)/dy) + 1; %roost_j = round((roo.y - y0)/dy) + 1;
% roost_r = round(roo.r / dx);
% minX = (roost_i-roost_r);
% minY = (roost_j-roost_r);
% box_d = roost_r*2;
% RECT = [ minX minY box_d box_d ]
% 
% roo = roosts([roosts.r] == minRadius);
% fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
%         roo.station, roo.year, roo.month, roo.day, roo.filename);
% radar = rsl2mat(fileName, roo.station); 
% [x,y,Z] = getDisplay(radar);
% %%more successful attempts at scaling
% %figure(2)
% % im = imagesc(VR);
% % set(gca,'visible','off');
% x0 = min(x);
% y0 = min(y);
% dx = mean(abs(diff(x)));   % meters per pixel
% dy = mean(abs(diff(y)));   % meters per pixel
% %hold on;
% roost_i = round((roo.x - x0)/dx) + 1; %roost_i = round((roo.x - x0)/dx) + 1;
% roost_j = round((max(y)-roo.y)/dy) + 1; %roost_j = round((roo.y - y0)/dy) + 1;
% roost_r = round(roo.r / dx);
% minX = (roost_i-roost_r);
% minY = (roost_j-roost_r);
% box_d = roost_r*2;
% RECT = [ minX minY box_d box_d ]