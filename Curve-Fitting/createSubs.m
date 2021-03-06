function [ subs ] = createSubs( dz,r )
    
   %make general with for-loop 
   %take center of bin for plotting 
    subs = zeros(size(dz));
    subs(r < 500) = 1;
    subs(r >= 500 & r < 1000) = 2;
    subs(r >= 1000 & r < 1500) = 3;
    subs(r >= 1500 & r < 2000) = 4;
    subs(r >= 2000 & r < 2500) = 5;
    subs(r >= 2500 & r < 3000) = 6;
    subs(r >= 3000 & r < 3500) = 7;
    subs(r >= 3500 & r < 4000) = 8;
    subs(r >= 4000 & r < 4500) = 9;
    subs(r >= 4500 & r < 5000) = 10;
    subs(r >= 5000 & r < 5500) = 11;
    subs(r >= 5500 & r < 6000) = 12;
    subs(r >= 6000 & r < 6500) = 13;
    subs(r >= 6500 & r < 7000) = 14;
    subs(r >= 7000 & r < 7500) = 15;
    subs(r >= 7500 & r < 8000) = 16;
    subs(r >= 8000 & r < 9500) = 17;
    subs(r >= 9500 & r < 10000) = 18;
    subs(r >= 10000 & r < 10500) = 19;
    subs(r >= 10500 & r < 11000) = 20;
    subs(r >= 11000 & r < 11500) = 21;
    subs(r >= 11500 & r < 12000) = 22;
    subs(r >= 12000 & r < 12500) = 23;
    subs(r >= 12500 & r < 13000) = 24;
    subs(r >= 13000 & r < 13500) = 25;
    subs(r >= 13500 & r < 14000) = 26;
    subs(r >= 14000 & r < 14500) = 27;
    subs(r >= 14500 & r < 15000) = 30;
    subs(r >= 15000 & r < 15500) = 31;
    subs(r >= 15500 & r < 16000) = 32;
    subs(r >= 16000 & r < 16500) = 33;
    subs(r >= 16500 & r < 17000) = 34;
    subs(r >= 17000 & r < 17500) = 35;
    subs(r >= 17500 & r < 18000) = 36;
    subs(r >= 18000 & r < 18500) = 37;
    subs(r >= 18500 & r < 19000) = 38;
    subs(r >= 19000 & r < 19500) = 39;
    subs(r >= 19500 & r < 20000) = 40;
    subs(r >= 20000 & r < 20500) = 41;
    subs(r >= 20500 & r < 21000) = 42;
    subs(r >= 21000 & r < 21500) = 43;
    subs(r >= 21500 & r < 22000) = 44;
    subs(r >= 22000 & r < 22500) = 45;
    subs(r >= 22500 & r < 23000) = 46;
    subs(r >= 23000 & r < 23500) = 47;
    subs(r >= 23500 & r < 24000) = 48;
    subs(r >= 24000 & r < 24500) = 49;
    subs(r >= 24500 & r < 25000) = 50;
    subs(r >= 25000 & r < 25500) = 51;
    subs(r >= 25500 & r < 26000) = 52;
    subs(r >= 26000 & r < 26500) = 53;
    subs(r >= 26500 & r < 27000) = 54;
    subs(r >= 27000 & r < 27500) = 55;
    subs(r >= 27500 & r < 28000) = 56;
    subs(r >= 28000 & r < 28500) = 57;
    subs(r >= 28500 & r < 29000) = 58;
    subs(r >= 29000 & r < 29500) = 59;
    subs(r >= 29500 & r < 30000) = 60;
    subs(r >= 30000 & r < 30500) = 61;
    subs(r >= 30500 & r < 31000) = 62;
    subs(r >= 31000 & r < 31500) = 63;
    subs(r >= 31500 & r < 32000) = 64;
    subs(r >= 32000 & r < 32500) = 65;
    subs(r >= 32500 & r < 33000) = 66;
    subs(r >= 33000 & r < 33500) = 67;
    subs(r >= 33500 & r < 34000) = 68;
    subs(r >= 34000 & r < 34500) = 69;
    subs(r >= 34500 & r < 35000) = 70;
    subs(r >= 35000 & r < 35500) = 71;
    subs(r >= 35500 & r < 36000) = 72;
    subs(r >= 36000 & r < 36500) = 73;
    subs(r >= 36500 & r < 37000) = 74;
    subs(r >= 37000 & r < 37500) = 75;
    subs(r >= 37500 & r < 38000) = 76;
    subs(r >= 38000 & r < 38500) = 61;
    subs(r >= 38500 & r < 39000) = 62;
    subs(r >= 39000 & r < 39500) = 63;
    subs(r >= 39500 & r < 40000) = 64;
    subs(r >= 40000 & r < 40500) = 65;
    subs(r >= 40500 & r < 41000) = 66;
    subs(r >= 41000 & r < 41500) = 67;
    subs(r >= 41500 & r < 42000) = 68;
    subs(r >= 42000 & r < 42500) = 69;
    subs(r >= 42500 & r < 43000) = 70;
    subs(r >= 43000 & r < 43500) = 71;
    subs(r >= 43500 & r < 44000) = 72;
    subs(r >= 44000 & r < 44500) = 73;
    subs(r >= 44500 & r < 45000) = 74;
    subs(r >= 45000 & r < 45500) = 75;
    subs(r >= 45500 & r < 46000) = 76;
    subs(r >= 46000 & r < 46500) = 61;
    subs(r >= 46500 & r < 47000) = 62;
    subs(r >= 47000 & r < 47500) = 63;
    subs(r >= 47500 & r < 48000) = 64;
    subs(r >= 48000 & r < 48500) = 65;
    subs(r >= 48500 & r < 49000) = 66;
    subs(r >= 49000 & r < 49500) = 67;
    subs(r >= 49500 & r < 50000) = 68;
    subs(r >= 50000 & r < 55500) = 69;
    subs(r >= 55500 & r < 56000) = 70;
    subs(r >= 56000 & r < 56500) = 71;
    subs(r >= 56500 & r < 57000) = 72;
    subs(r >= 57000 & r < 57500) = 73;
    subs(r >= 57500 & r < 58000) = 74;
    subs(r >= 58000 & r < 58500) = 75;
    subs(r >= 58500 & r < 59000) = 76;
    subs(r >= 59000 & r < 59500) = 77;
    subs(r >= 59500 & r < 60000) = 78;
    subs(r >= 60000 & r < 60500) = 79;
    subs(r >= 60500 & r < 61000) = 80;
    subs(r >= 61000 & r < 61500) = 81;
    subs(r >= 61500 & r < 62000) = 82;
    subs(r >= 62000 & r < 62500) = 83;
    subs(r >= 62500 & r < 63000) = 84;
    subs(r >= 63000 & r < 63500) = 85;
    subs(r >= 63500 & r < 64000) = 86;
    subs(r >= 64000 & r < 64500) = 87;
    subs(r >= 64500 & r < 65000) = 88;
    subs(r >= 65000 & r < 65500) = 89;
    subs(r >= 65500 & r < 66000) = 90;
    subs(r >= 66000 & r < 66500) = 91;
    subs(r >= 66500 & r < 67000) = 92;
    subs(r >= 67000 & r < 67500) = 93;
    subs(r >= 67500 & r < 68000) = 94;
    subs(r >= 68000 & r < 68500) = 95;
    subs(r >= 68500 & r < 69000) = 96;
    subs(r >= 69000 & r < 69500) = 97;
    subs(r >= 69500 & r < 70000) = 98;
    subs(r >= 70000 & r < 70500) = 99;
    

end

