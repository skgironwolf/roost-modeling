%%%%%%%%%Code for calculating circle-circle intersection and generating plots (Ignore for now) %%%%%%%%%%%%
load('test1_unfiltered.mat');

seq_id = zeros(327);
scan_id = zeros(327);
scan_id = ids(:,1);
seq_id = ids(:,2);
scan_id = scan_id(scan_id ~= 0);
seq_id = seq_id(seq_id ~= 0);
data = zeros(size(scan_id,1),4);

for i=1:1    %size(scan_id)
  [roo,radar,DZ] = getRoost(scan_id(i),seq_id(i)); 
  data(i,1) = scan_id(i);
  data(i,2) = seq_id(i);
  G = zeros(2,3);
    G(1,1) = params(i,1);
    G(2,1) = roo.x;
    G(1,2) = params(i,2);
    G(2,2) = roo.y;
    G(1,3) = params(i,3);
    G(2,3) = roo.r;
  M = area_intersect_circle_analytical(G);
  data(i,3) = i;
  data(i,4) = abs(pi*(roo.r)^2 - sum(M(:))); %sum(M(:)); 
end 

figure(1);
scatter(data(:,3),data(:,4));