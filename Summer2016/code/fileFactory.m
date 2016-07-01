%%%Generation of .dat file (Experimentation, IGNORE) %%%%%%%%%%%
load('frameInfo.mat');
fileName = '/Users/saadia/Desktop/wsrlib/positiveSamples/info.dat';
numSamples = 254;
X = zeros(numSamples,1);
Y = zeros(numSamples,1);
W = zeros(numSamples,1);
H = zeros(numSamples,1);

X = X + rect(1);
Y = Y + rect(2);
W = W + rect(3);
H = H + rect(4);

fileID = fopen(fileName,'w');
formatSpec = '/Users/saadia/Desktop/wsrlib/positiveSamples 1 %d %d %d %d\n';
fprintf(formatSpec, X, Y, W, H);
fclose(fileID);