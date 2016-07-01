allFiles = dir( '/Users/saadia/Desktop/testingdata' );
allNames = {allFiles(~[allFiles.isdir]).name};


for i=1:size(allNames,2)
filename = allNames{i};
radar_file = sprintf('%s%s','/Users/saadia/Desktop/testingdata/',filename);
station    = 'KDOX';
radar      = rsl2mat(radar_file, station);
[x,y,Z]    = getDisplay(radar);
%% scale VR. map range [-20 20] into [0 1], then set NaN to 0
dzlim = [-20 20];
Z = (Z - dzlim(1))/(dzlim(2) - dzlim(1));
Z(isnan(Z)) = 0;
imwrite(Z,sprintf('%s%s%s','/Users/saadia/Desktop/wsrlib/TestingData_DZ/',filename,'.png'));

%%Get VR images %%
VR = getVR(radar);
%% scale VR. map range [-20 20] into [0 1], then set NaN to 0
vrlim = [-20 20];
VR = (VR - vrlim(1))/(vrlim(2) - vrlim(1));
VR(isnan(VR)) = 0;
imwrite(VR,sprintf('%s%s%s','/Users/saadia/Desktop/wsrlib/TestingData_VR/',filename,'.png'));

im1 = imread(sprintf('%s%s%s','/Users/saadia/Desktop/wsrlib/TestingData_DZ/',filename,'.png'));
im2 = imread(sprintf('%s%s%s','/Users/saadia/Desktop/wsrlib/TestingData_VR/',filename,'.png'));
im3 = imfuse(im1,im2);
im3 = rgb2gray(im3);
imwrite(im3,sprintf('%s%s%s','/Users/saadia/Desktop/wsrlib/TestingData_Both/',filename,'.png'));
end