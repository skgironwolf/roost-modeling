function [ uwind,vwind ] = windshift( roost,scani,seqi,windspeed)
%windshift finds a wind velocity vector based on the movement of the roost
%center from scan to the next scan 
%if the roost only appears in one scan, it defaults to a velocity vector
%with a speed input by the user

%retrieve another scan of the roost 
label_file = 'labels-KDOX-2011.csv';
roosts = csv2struct(label_file, '%f%s%f%s%f%f%f%f%f%f%f%f%f%f'); 
r = roosts([roosts.scan_id] ~= scani);
r = r([r.sequence_id] == seqi);

%if there is another scan, calculate the velocity vector using the x,y
%shifts (divide by difference (in seconds) between scans)
if(size(r,2) ~= 0)
    shiftr = r(1);
    td = abs(roost.minutes_from_sunrise-shiftr.minutes_from_sunrise);
    uwind = (roost.x-shiftr.x)/(td*60);
    vwind = (roost.y-shiftr.y)/(td*60);
else
    %default wind velocity vector
    uwind = -1/sqrt(2)*windspeed;
    vwind = 1/sqrt(2)*windspeed;
end


end

