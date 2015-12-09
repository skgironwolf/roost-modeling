load('speedData.mat');
muWind = mean(speed(:,1))
muBird = mean(speed(:,2))
sigmaWind = var(speed(:,1))
sigmaBird = var(speed(:,2))

WindX = 0:1:max(speed(:,1));
BirdX = 0:1:max(speed(:,2));
subs = createSubs2(WindX.',speed(:,1),1);
windProb = accumarray(subs,speed(:,1),[],@getProbability);
subs2 = createSubs2(WindX.',speed(:,2),1);
birdProb = accumarray(subs2,speed(:,2),[],@getProbability);
figure(1)
plot(BirdX,birdProb);
%plot(WindX,windProb);
[birdCurve,gof] = fit(BirdX.',birdProb,'gauss1');
hold on;
plot(birdCurve);
figure(2)
plot(WindX,windProb);
[windCurve,gof] = fit(WindX.',windProb,'gauss1');
hold on;
plot(windCurve);

%plot(generalCurve2);
%plot((5.6318)*exp((-((x-6.2463)).^2)./(2*(2.1811)^2)));
%plot(a1*exp(-((x-b1)/c1)^2));
%save('Probability.mat','birdCurve','windCurve');



