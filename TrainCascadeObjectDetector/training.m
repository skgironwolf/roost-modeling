load('detectionData.mat');
imDir = '/positiveSamples';
addpath(imDir);
negativeFolder = '/negativeSamples';
trainCascadeObjectDetector('roostDetection.xml',data,negativeFolder);