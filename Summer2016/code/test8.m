label_file = 'labels-KDOX-2011.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
nRoosts = numel(roosts); % number of roosts

%mins stores loss function fmincon local mins 
mins = zeros(nRoosts);
params = zeros(nRoosts,4);
ids = zeros(nRoosts,2);
options = [];
options.numDiff = 1;
options.optTol =  1e-1;
options.maxIter = 200;
%go through roosts and run through loss function (lf), then minimize lf
tic 
for i=1:nRoosts

%get ith roost     
roo = roosts(i);
roo.scan_id 
roo.sequence_id 
%get data root 
dataRoot = '/Users/saadia/Desktop';
%get file name 
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        roo.station, roo.year, roo.month, roo.day, roo.filename);
%get radar 
radar = rsl2mat(fileName, roo.station);

[x,y,DZ] = getDisplay(radar);
VR = getVR(radar );
[Y, X] = ndgrid(y,x);
 
%roost filtering
% if((roo.scan_id ~= 156099 && roo.sequence_id ~= 6313)&&(roo.scan_id ~= 156100 && roo.sequence_id ~= 6314)&&(roo.scan_id ~= 158637 && roo.sequence_id ~= 1669)&&(roo.scan_id ~= 158638 && roo.sequence_id ~= 1670)&&(roo.scan_id ~= 158636 && roo.sequence_id ~= 1671)&&(roo.scan_id ~= 164976 && roo.sequence_id ~= 1672)&&(roo.scan_id ~= 164974 && roo.sequence_id ~= 1673)&&(roo.scan_id ~= 164975 && roo.sequence_id ~= 1674)&&(roo.scan_id ~= 175024 && roo.sequence_id ~= 6315)&&(roo.scan_id ~= 175025 && roo.sequence_id ~= 6316)&&(roo.scan_id ~= 175026 && roo.sequence_id ~= 6317)&&(roo.scan_id ~= 175427 && roo.scan_id ~= 6318)&&(roo.scan_id ~= 175428 && roo.sequence_id ~= 6318)&&(roo.scan_id ~= 175429 && roo.sequence_id ~= 6319)&&(roo.scan_id ~= 175894 && roo.sequence_id ~= 6320)&&(roo.scan_id ~= 176315 && roo.sequence_id ~= 6322)&&(roo.scan_id ~= 176314 && roo.sequence_id ~= 6323)&&(roo.scan_id ~= 176316 && roo.sequence_id ~= 6324)&&(roo.scan_id ~= 177667 && roo.sequence_id ~= 6325)&&(roo.scan_id ~= 177668 && roo.sequence_id ~= 6326)&&(roo.scan_id ~= 184697 && roo.sequence_id ~= 6327)) %11        

%get x,y,r parameters 
x0 = roo.x;
y0 = roo.y;
radius = roo.r;

%set up constraints to get pulse volumes within a bounding box that scales to the size
%of the roost radius 
border2 = X < (x0+2*radius) & X > (x0-2*radius) & Y < (y0+2*radius) & Y > (y0-2*radius);

%get reflectivity in decibels and X,Y coordinates for pulse volumes within
%bounding box (remove NaN reflectivity values and corresponding
%coordinates) 
 vr = VR(border2);
 dbZ = DZ(border2);
 Y = Y(border2);
 X = X(border2);

 %set upper and lower bound limits for fmincon parameters, with cases for
 %negative x,y parameter values 
lb = [min(X),min(Y),min([roosts.r]),0,0];
ub = [max(X),max(Y),max([roosts.r]),2000,20];%change a's upper limit to 35 from 100

%just some code I was trying out, ignore 
% A = [0 0 0 -1;0 0 1 0; 0 0 -1 0; 0 1 0 0; 1 0 0 0; 0 -1 0 0; -1 0 0 0];
% b = [0;radius*2;0;y0+y0*.5;x0+x0*.5;-y0+y0*.5;-x0+x0*.5];
% rx = rand*80000*(x0/abs(x0))
% ry = rand*80000*(y0/abs(y0))
% rr = rand*40000
% ra = rand*10
theta = [0,0,0,0,6.8];
% %find a feasible point (a point within constraints) 
f = zeros(size(theta)); 
theta = linprog(f,[],[],[],[],lb,ub);
[uwind,vwind] = windshift(roo,roo.scan_id,roo.sequence_id,5);
%set fmincon options and create anonymous function 
options = optimoptions('fmincon','Display','iter','MaxFunEvals',15000,'TolX',1e-12);
lf = @(theta)lossF16(theta,X,Y,dbZ,vr,uwind,vwind);
lossF16(theta,X,Y,dbZ,vr,uwind,vwind);
%this was just for testing 
%save('roostDB','dbZ','DZ','roo','X2','Y2');

%find min and store 
% m = fmincon(lf,theta,[],[],[],[],lb,ub,[],options);
% m = fmincon(lf,m,[],[],[],[],lb,ub,[],options);

m = fmincon(lf,theta,[],[],[],[],lb,ub,[],options);
%m = minConf_TMP(lf,theta,lb',ub',options);

mins(i) = lf(m); 
ids(i,1) = roo.scan_id;
ids(i,2) = roo.sequence_id;
params(i,1) = m(1); 
params(i,2) = m(2); 
params(i,3) = m(3); 
params(i,4) = m(4);  
save('testA_unfiltered','mins','params','ids','i');
% pause; 

%min = fminunc(@practiceFun,x)
%practiceFun(min)
%end

end
toc 