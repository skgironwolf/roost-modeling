%label_file = 'labels-KDOX-2011.csv';
label_file = 'labels-KDOX-2011-2010.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
nRoosts = numel(roosts); % number of roosts 
array = [roosts.scan_id];
fid=fopen('/Users/saadia/Desktop/wsrlib/positiveSamples_DZ/info.dat','w');
%go through roosts and run through loss function (lf), then minimize lf
for i=1:nRoosts
    
roo = roosts(i);
if((roo.scan_id ~= 156099 && roo.sequence_id ~= 6313)&&(roo.scan_id ~= 156100 && roo.sequence_id ~= 6314)&&(roo.scan_id ~= 158637 && roo.sequence_id ~= 1669)&&(roo.scan_id ~= 158638 && roo.sequence_id ~= 1670)&&(roo.scan_id ~= 158636 && roo.sequence_id ~= 1671)&&(roo.scan_id ~= 164976 && roo.sequence_id ~= 1672)&&(roo.scan_id ~= 164974 && roo.sequence_id ~= 1673)&&(roo.scan_id ~= 164975 && roo.sequence_id ~= 1674)&&(roo.scan_id ~= 175024 && roo.sequence_id ~= 6315)&&(roo.scan_id ~= 175025 && roo.sequence_id ~= 6316)&&(roo.scan_id ~= 175026 && roo.sequence_id ~= 6317)&&(roo.scan_id ~= 175427 && roo.scan_id ~= 6318)&&(roo.scan_id ~= 175428 && roo.sequence_id ~= 6318)&&(roo.scan_id ~= 175429 && roo.sequence_id ~= 6319)&&(roo.scan_id ~= 175894 && roo.sequence_id ~= 6320)&&(roo.scan_id ~= 176315 && roo.sequence_id ~= 6322)&&(roo.scan_id ~= 176314 && roo.sequence_id ~= 6323)&&(roo.scan_id ~= 176316 && roo.sequence_id ~= 6324)&&(roo.scan_id ~= 177667 && roo.sequence_id ~= 6325)&&(roo.scan_id ~= 177668 && roo.sequence_id ~= 6326)&&(roo.scan_id ~= 184697 && roo.sequence_id ~= 6327)) 
roo.scan_id 
roo.sequence_id
%%%%%%%%%%% Get Roost Images %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataRoot = '/Users/saadia/Desktop';
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        roo.station, roo.year, roo.month, roo.day, roo.filename);
radar = rsl2mat(fileName, roo.station); 
[x,y,Z] = getDisplay(radar);
dzlim = [-5 30];
figure(1)
[Y, X] = ndgrid(y,x);
border2 = (X < (roo.x+1.5*roo.r) & X > (roo.x-1.5*roo.r) & Y < (roo.y+1.5*roo.r) & Y > (roo.y-1.5*roo.r));
%display window limits
xlimit = [min(X(border2)) max(X(border2))];
ylimit = [min(Y(border2)) max(Y(border2))];

%colormap(dzmap(32));
im = imagesc(x,y,Z, dzlim);
set(gca,'visible','off');
xlim(xlimit);
ylim(ylimit);
xlim(xlimit);
ylim(ylimit);
% saveas(figure(1),sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples/',roo.scan_id,'_',roo.sequence_id,'.png'));

% % scale VR. map range [-20 20] into [0 1], then set NaN to 0
% vrlim = [-20 20];
% VR = (VR - vrlim(1))/(vrlim(2) - vrlim(1));
% VR(isnan(VR)) = 0;
% imwrite(VR, 'foo.png')
% 
% 
% imwrite(im.CData,vrmap2(32),sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples/',roo.scan_id,'sample',roo.sequence_id,'.png'));
% pause;

%%%%%%%%%%%% Removing of Frame %%%%%%%%%%%%%%%%%%%%
% image = imread(sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples/',roo.scan_id,'_',roo.sequence_id,'.png'));
% imshow(image, []);
% %colormap(vrmap(32));
% hold on;
% % r_pix = (roo.r)/600;
% % x_pix = ((roo.x + max(x))/600) + 300;
% % y_pix = ((roo.y + max(y))/600) + 100;
% rect = [156 50 930 750];
% rectangle('position',rect,'facecolor', 'r');
%save('frameInfo','rect');
%pause;

% early attempts at scaling 
% r_pix = (roo.r)/600;
% x_pix = (roo.x + max(x))/600;
% y_pix = (roo.y + max(y))/600;
% 
% minX = x_pix - 1.5*r_pix;
% minY = y_pix + r_pix;
% Width = 4*r_pix;
% Height = 4*r_pix;
% RECT = [ minX minY Width Height ];
%image = imcrop(im.CData, vrmap2(32), RECT);

%%more successful attempts at scaling
%figure(2)
% im = imagesc(VR);
% set(gca,'visible','off');
x0 = min(x);
y0 = min(y);
dx = mean(abs(diff(x)));   % meters per pixel
dy = mean(abs(diff(y)));   % meters per pixel
%hold on;
roost_i = round((roo.x - x0)/dx) + 1; %%roost_i = round((roo.x - x0)/dx) + 1;
roost_j = round((max(y)-roo.y)/dy) + 1; %%roost_j = round((roo.y - y0)/dy) + 1;
roost_r = round(roo.r / dx);
minX = (roost_i - 2*roost_r); % minX = (roost_i-roost_r);
minY = (roost_j - 2*roost_r);   % minY = (roost_j-roost_r);
box_d = roost_r*4; % box_d = roost_r*2;
RECT = [ minX minY box_d box_d ];
%rectangle('position',RECT,'facecolor','r');
% pause;
%% scale VR. map range [-20 20] into [0 1], then set NaN to 0
dzlim = [-20 20];
Z = (Z - dzlim(1))/(dzlim(2) - dzlim(1));
Z(isnan(Z)) = 0;
%image = imcrop(VR,'gray',RECT);
%imwrite(image,'foo.png');
file = sprintf('%s%d%s%d%s','positiveSamples_DZ/',roo.scan_id,'-',roo.sequence_id,'.png');
fprintf(fid, '%s %d %d %d %d %d \n', file, [ 1 RECT(1) RECT(2) RECT(3) RECT(4)]); %size(array(array == roo.scan_id),2)
imwrite(Z,sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples_DZ/',roo.scan_id,'-',roo.sequence_id,'.png'));
%pause;

end
end
fclose(fid);