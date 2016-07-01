% plot Jaccard Index curve (for complementary curve, use plot(x,1-f)
load('jaccardIndex_testA9');
figure(2);
[f,x] = ecdf(jaccardIndex(:,1));
plot(x,f);

%mean jaccard singularity: .1841
%mean jaccard singularity: .3093
%mean jaccard singularity: .2817