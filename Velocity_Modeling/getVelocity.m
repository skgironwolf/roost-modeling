function [Velocity,UV,VV,vr] = getVelocity(x0,y0,X,Y,windspeed,bspeed)
%       
%     Velocity = {size(X)};
%     UV = zeros(size(X));
%     VV = zeros(size(X));
%     Vr = zeros(size(X));
    
    [Velocity,UV,VV,vr] = velocity_modeling(x0,y0,X,Y,windspeed,bspeed);
%     for i=1:size(X)
%     
%      for j = 1:360
%      x = X(i,j);
%      y = Y(i,j);
%      [W,U,V,vr] = velocity_modeling(x0,y0,x,y,windspeed,bspeed);
%      UV(i,j) = U;
%      VV(i,j) = V;
%      Velocity{i,j} = W;
%      Vr(i,j) = vr;
%      end
%     end
    
     %save('veloc','V','UV','VV');
    
    
end