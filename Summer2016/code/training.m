load('dataMatlab.mat');
imDir = '/Users/saadia/Desktop/wsrlib/positiveSamples_VR'; 
addpath(imDir);
negativeFolder = 'Users/saadia/Desktop/wsrlib/negativeVR';
trainCascadeObjectDetector('roostDetection.xml',data,negativeFolder);