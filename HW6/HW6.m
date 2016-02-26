% Sean Bennett
% HW6

%% Question 1

load('CancerMicroarray.mat')

numTumors = length(G)
numGenes = length(X)

% There are 2308 different genes sequenced from 83 different tumors.

[coeffPC, scorePC, latentPC] = pca(X);

cumulativeLatent = cumsum(latentPC) / sum(latentPC);

numPC = max(find(cumulativeLatent < 0.95));

% You need 52 or 53 PCs to explain 95% of the data

figure;
hold on;
stairs(cumulativeLatent, 'Color', 'r');
title('Explained Variation by PC');
refline(0, 0.95);
line([52 52],[0 1]);
hold off;

trainingindicies = randsample(1:numTumors, 66);
testindicies = 1:83;
testindicies(ismember(testindicies,trainingindicies)) = [];

trainingdata = X(trainingindicies,:);
testdata = X(testindicies,:);
trainingClass = G(trainingindicies);
testClass = G(testindicies);

linClass = fitcdiscr(trainingdata, trainingClass);
testPred = predict(linClass, testdata);

quadClass = fitdiscr(trainingdata, trainingClass, 'DiscrimType', 'quad');

%[classObs, errorObs] = classify 


%% Question 2

