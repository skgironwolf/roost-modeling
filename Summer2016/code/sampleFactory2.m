label_file = 'labels-KDOX-2011-2010.csv';

% Get struct array with all roosts
%   Note: second argument gives format specifiers
%     these are fairly universal. See help sprintf, fprintf
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
nRoosts = numel(roosts); % number of roosts


%go through roosts and run through loss function (lf), then minimize lf
for i=1:nRoosts
roo = roosts(i); 
roo.scan_id 
roo.sequence_id
roo.filename
%%%%%%%%%%% Get Roost Images %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataRoot = '/Users/saadia/Desktop';
fileName = sprintf('%s/%s/%04d/%02d/%02d/%s', dataRoot, ...
        roo.station, roo.year, roo.month, roo.day, roo.filename);
radar = rsl2mat(fileName, roo.station); 
[x,y,Z] = getDisplay(radar);
VR = getVR(radar);
vrlim = [-15 15];
figure(1)
[Y, X] = ndgrid(y,x);
border2 = (X < (roo.x+1.5*roo.r) & X > (roo.x-1.5*roo.r) & Y < (roo.y+1.5*roo.r) & Y > (roo.y-1.5*roo.r));
%display window limits
xlimit = [min(X(border2)) max(X(border2))];
ylimit = [min(Y(border2)) max(Y(border2))];

colormap(vrmap(32));
im = imagesc(x,y,VR, vrlim);
set(gca,'visible','off');
xlim(xlimit);
ylim(ylimit);
xlim(xlimit);
ylim(ylimit);
saveas(figure(1),sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples/',roo.scan_id,'_',roo.sequence_id,'.pgm'));

% imwrite(im.CData,vrmap2(32),sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples/',roo.scan_id,'_',roo.sequence_id,'.png'));

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
% % %save('frameInfo','rect');
% pause;



%pause;
% im = imagesc(x,y,VR, vrlim);

% r_pix = (roo.r)/600;
% x_pix = (roo.x + max(x))/600;
% y_pix = (roo.y + max(y))/600;
% 
% minX = x_pix - 1.5*r_pix;
% minY = y_pix + r_pix;
% Width = 4*r_pix;
% Height = 4*r_pix;
% RECT = [ minX minY Width Height ];
% image = imcrop(im.CData, vrmap2(32), RECT);
% imwrite(image, vrmap2(32),sprintf('%s%d%s%d%s','/Users/saadia/Desktop/wsrlib/positiveSamples/',roo.scan_id,'_',roo.sequence_id,'.png'));
end