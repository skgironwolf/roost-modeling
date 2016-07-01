%%%%% Get Names Of Files Containing Roosts %%%%%

% label_file = 'labels-KDOX-2011.csv';
% 
% % Get struct array with all roosts
% %   Note: second argument gives format specifiers
% %     these are fairly universal. See help sprintf, fprintf
% roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f');
% nRoosts = numel(roosts); % number of roosts
% 
% %mins stores loss function fmincon local mins 
% roostFiles = cell(1, nRoosts);
% 
% %go through roosts and run through loss function (lf), then minimize lf
% for i=1:nRoosts
% 
% %get ith roost     
% theRoost = roosts(i);
% %get data root 
% dataRoot = '';
% %get file name 
% roostFiles(i) = {theRoost.filename};
% end
% save('roostFileNames','roostFiles');

%%%%% Get Names of Files Not Containing Roosts %%%%%

% allFiles1 = dir( '/Users/saadia/Desktop/KDOX/2011/10/01' );
% allFiles2 = dir( '/Users/saadia/Desktop/KDOX/2011/10/02' );
% allFiles3 = dir( '/Users/saadia/Desktop/KDOX/2011/10/03' );
% allFiles4 = dir( '/Users/saadia/Desktop/KDOX/2011/10/04' );
% allFiles5 = dir( '/Users/saadia/Desktop/KDOX/2011/10/05' );
% allFiles6 = dir( '/Users/saadia/Desktop/KDOX/2011/10/06' );
% allFiles7 = dir( '/Users/saadia/Desktop/KDOX/2011/10/07' );
% allFiles8 = dir( '/Users/saadia/Desktop/KDOX/2011/10/08' );
% allFiles9 = dir( '/Users/saadia/Desktop/KDOX/2011/10/09' );
% allFiles10 = dir( '/Users/saadia/Desktop/KDOX/2011/10/10' );
% allFiles11 = dir( '/Users/saadia/Desktop/KDOX/2011/10/11' );
% allFiles12 = dir( '/Users/saadia/Desktop/KDOX/2011/10/12' );
% allFiles13 = dir( '/Users/saadia/Desktop/KDOX/2011/10/13' );
% allFiles14 = dir( '/Users/saadia/Desktop/KDOX/2011/10/14' );
% allFiles15 = dir( '/Users/saadia/Desktop/KDOX/2011/10/15' );
% allNames1 = {allFiles1(~[allFiles1.isdir]).name};
% allNames2 = {allFiles2(~[allFiles2.isdir]).name};
% allNames3 = {allFiles3(~[allFiles3.isdir]).name};
% allNames4 = {allFiles4(~[allFiles4.isdir]).name};
% allNames5 = {allFiles5(~[allFiles5.isdir]).name};
% allNames6 = {allFiles6(~[allFiles6.isdir]).name};
% allNames7 = {allFiles7(~[allFiles7.isdir]).name};
% allNames8 = {allFiles8(~[allFiles8.isdir]).name};
% allNames9 = {allFiles9(~[allFiles9.isdir]).name};
% allNames10 = {allFiles10(~[allFiles10.isdir]).name};
% allNames11 = {allFiles11(~[allFiles11.isdir]).name};
% allNames12 = {allFiles12(~[allFiles12.isdir]).name};
% allNames13 = {allFiles13(~[allFiles13.isdir]).name};
% allNames14 = {allFiles14(~[allFiles14.isdir]).name};
% allNames15 = {allFiles15(~[allFiles15.isdir]).name};
% 
% save('KDOXFileNames','allNames1','allNames2','allNames3','allNames4','allNames5','allNames6','allNames7','allNames8','allNames9','allNames10','allNames11','allNames12','allNames13','allNames14','allNames15');

%%%%% Filter Out Roosts %%%%%%

% load('roostFileNames.mat');
% load('KDOXFileNames.mat');
% 
% %All radar files without roosts 
% C1 = setdiff(allNames1,roostFiles);
% C2 = setdiff(allNames2,roostFiles);
% C3 = setdiff(allNames3,roostFiles);
% C4 = setdiff(allNames4,roostFiles);
% C5 = setdiff(allNames5,roostFiles);
% C6 = setdiff(allNames6,roostFiles);
% C7 = setdiff(allNames7,roostFiles);
% C8 = setdiff(allNames8,roostFiles);
% C9 = setdiff(allNames9,roostFiles);
% C10 = setdiff(allNames10,roostFiles);
% C11 = setdiff(allNames11,roostFiles);
% C12 = setdiff(allNames12,roostFiles);
% C13 = setdiff(allNames13,roostFiles);
% C14 = setdiff(allNames14,roostFiles);
% C15 = setdiff(allNames15,roostFiles);
% 
% save('filteredFiles','C1','C2','C3','C4','C5','C6','C7','C8','C9','C10','C11','C12','C13','C14','C15');

%%%%%%Create Negative Samples%%%%%%
% %%Reflectivity%%
% station  = 'KDOX';
% dataRoot = '/Users/saadia/Desktop/KDOX_unfiltered';
% j = 1856; %change
% for i = 2:size(C15,2) %change
% radar_file = C15{i};  %change
% radar_file = (sprintf('%s/%s', dataRoot,radar_file));
% radar      = rsl2mat(radar_file, station);
% [x,y,Z] = getDisplay(radar);
% %% scale VR. map range [-20 20] into [0 1], then set NaN to 0
% dzlim = [-20 20];
% Z = (Z - dzlim(1))/(dzlim(2) - dzlim(1));
% Z(isnan(Z)) = 0;
% imwrite(Z,sprintf('%s%d%s','/Users/saadia/Desktop/wsrlib/negativeSamples/',j,'.pgm'));
% j = j + 1;

% %%Radial Velocity%%
% station  = 'KDOX';
% dataRoot = '/Users/saadia/Desktop/KDOX_unfiltered';
% j = 1676; %change
% for i = 2:size(C15,2) %change
% radar_file = C15{i};  %change
% radar_file = (sprintf('%s/%s', dataRoot,radar_file));
% radar      = rsl2mat(radar_file, station);
% [x,y,Z] = getDisplay(radar);
% VR = getVR(radar);
% %% scale VR. map range [-20 20] into [0 1], then set NaN to 0
% vrlim = [-20 20];
% VR = (VR - vrlim(1))/(vrlim(2) - vrlim(1));
% VR(isnan(VR)) = 0;
% imwrite(VR,sprintf('%s%d%s','/Users/saadia/Desktop/wsrlib/negativeSamples/',j,'_VR.pgm'));
% j = j + 1;

%%Radial Velocity%%
load('CFile.mat');
station  = 'KDOX';
dataRoot = '/Users/saadia/Desktop/KDOX_unfiltered';
j = 1;
for i = 1:size(C,1) %change
radar_file = C{i};  %change
radar_file = (sprintf('%s/%s', dataRoot,radar_file));
radar      = rsl2mat(radar_file, station);
[x,y,Z] = getDisplay(radar);
VR = getVR(radar);
%% scale VR. map range [-20 20] into [0 1], then set NaN to 0
vrlim = [-20 20];
VR = (VR - vrlim(1))/(vrlim(2) - vrlim(1));
VR(isnan(VR)) = 0;
imwrite(VR,sprintf('%s%d%s','/Users/saadia/Desktop/wsrlib/negativeVR/',j,'.png'));
j = j + 1;

%%%Old Method 
% VR = getVR(radar);
% vrlim = [-15 15];
% figure(1)
% colormap(vrmap(32));
% im = imagesc(x,y,VR, vrlim);
% saveas(figure(1),sprintf('%s%d%s','/Users/saadia/Desktop/wsrlib/negativeSamples/',j,'.png'));
% j = j + 1;
end
