%get actual radial velocity
function [ VR] = getVR(radar )
    
    rmax = 150000; % 150km
    dim  = 600;    % 600 pixels
%     
%     % convert to cartesian
    VR = sweep2cart(radar.vr.sweeps(1), rmax, dim); % convert to cartesian
%     

end

