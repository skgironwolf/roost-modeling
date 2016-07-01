% val = 101:106';
% subs = [1 1; 2 2; 3 2; 1 1; 2 2; 4 1];
% accumarray(subs,val,[],@mean)
 v = [-4,3,5,90,.5]';
 r = [0,1,90,30,70]';

 subs = zeros(size(v));
 subs(r > 40) = 2;
 subs(r < 40) = 1;
 
% s = [size(v),1];
%  [I,J] = ind2sub(s,b2);
%  [I;J];
 %  b1 = r < 40;
%  b2 = r >= 40;
%  b3 = r > 80;
%  subs = {b1,b2,b3};
 
 
 accumarray(subs,v,[],@mean)