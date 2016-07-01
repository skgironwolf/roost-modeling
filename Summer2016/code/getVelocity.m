%gets velocity from velocity modeling
function [Velocity,UV,VV,vr] = getVelocity(x0,y0,X,Y,uwind,vwind,bspeed)

    
    [Velocity,UV,VV,vr] = velocity_modeling(x0,y0,X,Y,uwind,vwind,bspeed);

    
    
end