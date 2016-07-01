
%%%%%%%%%%%%%%%%  Performance Measure For Train-Cascade   %%%%%%%%%%%%%%%%%

%%%Get actual and detected roost data 
label_file = 'testingData.csv';

%read in detected roost data from 'rects.txt'
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

%display radar image
image = imread('/Users/saadia/Desktop/wsrlib/TestingData_DZ/KDOX20110919_104425_V04.png'); % change this depending on radar file being used
imshow(image, []);

%%%% go through all roosts (detected and actual) 
for i = 2:max(numObj + 2, nRoosts + 2)
   %store detected bounding boxes 
   if(i < (numObj + 2))
   rect = str2num(lines{i});
   rects_detected(i-1,1) = rect(1);
   rects_detected(i-1,2) = rect(2);
   rects_detected(i-1,3) = rect(3);
   rects_detected(i-1,4) = rect(4);
   %draw detected bounding boxes 
   hold on;
   rectangle('position',rects_detected(i-1,:),'edgecolor', 'y');
   rectangle('position',[(rects_detected(i-1,1)+(rects_detected(i-1,3)/2)) (rects_detected(i-1,2)+(rects_detected(i-1,4)/2)) 5 5], 'edgecolor','y')
   end
   %get and store actual bounding boxes 
   if(i < (nRoosts + 2))
       roo = roosts(i-1);
       dataRoot = '/Users/saadia/Desktop/testingdata';
       fileName = sprintf('%s/%s', dataRoot, roo.filename);
       radar = rsl2mat(fileName, roo.station);
       [x,y,Z] = getDisplay(radar);
       %scale for pixels vs. meters 
       x0 = min(x);
       y0 = min(y);
       dx = mean(abs(diff(x)));   % meters per pixel
       dy = mean(abs(diff(y)));   % meters per pixel
       
       %calculate bounding boxes 
       roost_i = round((roo.x - x0)/dx) + 1; %roost_i = round((roo.x - x0)/dx) + 1;
       roost_j = round((max(y)-roo.y)/dy) + 1; %roost_j = round((roo.y - y0)/dy) + 1;
       roost_r = round(roo.r / dx);
       minX = (roost_i-1.5*roost_r);
       minY = (roost_j-1.5*roost_r);
       box_d = roost_r*3;
       
       % store actual bounding boxes 
       rects_actual(i-1,1) = minX;
       rects_actual(i-1,2) = minY;
       rects_actual(i-1,3) = box_d;
       rects_actual(i-1,4) = box_d;
       
       %draw actual bounding boxes 
       hold on;
       rectangle('position',rects_actual(i-1,:),'edgecolor', 'r');
       hold on;
       rectangle('position',[roost_i roost_j 5 5], 'edgecolor','r');
   end   
end

%calculate Jaccard index for bounding boxes 
intersection = rectint(rects_detected,rects_actual);
[row,col] = find(intersection ~= 0);
results = zeros(numObj,1);
results_actualR = zeros(nRoosts,1);

for j = 1:size(row,1)
    area_detected = (rects_detected(row(j),3)*rects_detected(row(j),4));
    area_actual = (rects_actual(col(j),3)*rects_actual(col(j),4)); 
    result = intersection(row(j),col(j)) / ((area_detected + area_actual) - intersection(row(j),col(j)));
    results(row(j)) = max(results(row(j)),result);
    results_actualR(col(j)) = max(results_actualR(col(j)),result); 


end

%measure # of hits , misses, and false detects 

% lower bound for Jaccard Index  
accept_Rate = .4;

% calculate hitRate, missRate, # of false detects, and falseRate 
hitRate_actual = size(results_actualR(results_actualR > accept_Rate),1) / size(results_actualR,1)
missRate_actual = size(results_actualR((results_actualR <= accept_Rate)),1) / size(results_actualR,1)

filterresults = results(results ~= 0);
hitRate_detected = size(filterresults(filterresults > accept_Rate),1) / size(results,1)
missRate_detected = size(filterresults((filterresults <= accept_Rate)),1) / size(results,1)

falseDetects = size(results(results == 0),1)
falseRate = falseDetects / size(results,1)

% store which roosts were hits and which were misses 
resultSTR = cell(size(results_actualR));
resultSTR(:) = {'miss'};
resultSTR(results_actualR >= accept_Rate) = {'hit'};
resultSTR 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%