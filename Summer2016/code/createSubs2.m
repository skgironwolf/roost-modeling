function [ subs ] = createSubs2( dz,r,boxlimit)
    
   %make general with for-loop 
   %take center of bin for plotting 
   
   lower = 0; 
   upper = boxlimit;  
   subs = zeros(size(dz));
   for i=1:(ceil(max(r)/boxlimit))
    subs(r >= lower & r < upper) = i;
    lower = upper; 
    upper = lower+boxlimit; 
   end

end

