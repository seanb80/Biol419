%%
load ovariancancer.mat

%% 

test_frac = 0.2;
permuted = randperm(numel(scorePC(:,1)));
test = permuted(1:floor(numel(scorePC(:,1)) * test_frac));
train = permuted(ceil((numel(scorePC(:,1)) * test_frac)):end);

%%

[classObs, errorObs] = classify(scorePC(test,1), scorePC(train,1), grp(train));


G = zeros(numel(grp), 1);
G(strcmp(grp, 'Normal')) = 0;
G(strcmp(grp, 'Cancer')) = 1;

C = zeros(numel(classObs), 1);
C(strcmp(classObs, 'Normal')) = 0;
C(strcmp(classObs, 'Cancer')) = 1;


crossVal = mean(C == G(test));


%%


[coeffPC, scorePC, latentPC] = pca(obs(:,1:4000));
figure;
gscatter(obs(:,864), obs(:,1000), grp)

