 
function [ loss ] = lossF11( theta,X2,Y2,dbZ)
%Loss function with reflectivity
%X and Y coordinates for radial velocity / reflectivity (consider filtering
%out pixels that are nan for either from both) 
YZ = Y2(~isnan(dbZ));
XZ = X2(~isnan(dbZ));
%reflectivity values of pixels
dbZ = dbZ(~isnan(dbZ));

%%Vectorized Approach 

%get predicted reflectivity
dBZ_predicted = getDBZ_vec(XZ,YZ,theta(1),theta(2),theta(3),theta(4));
%get reflectivity error 
M1 = (dbZ - dBZ_predicted).^2;
errorZ = sum(M1(:));
%calculate loss 
loss = (errorZ) / max(size(X2));


end
