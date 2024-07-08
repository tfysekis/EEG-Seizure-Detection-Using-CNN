% Load the data
loadEEGData();

% Prepare the data
[trainData, trainLabels, validationData, validationLabels, testData, testLabels] = prepareEEGData();

% Calculate class weights
classWeights = numel(trainLabels)./(3 * countcats(trainLabels));

% Define different configurations
configurations = [
    struct('epochs', 10, 'dropout', 0.3, 'L2Regularization', 1e-3);
    struct('epochs', 20, 'dropout', 0.4, 'L2Regularization', 1e-3);
    struct('epochs', 30, 'dropout', 0.5, 'L2Regularization', 1e-3);
    struct('epochs', 40, 'dropout', 0.6, 'L2Regularization', 1e-3);
    struct('epochs', 10, 'dropout', 0.5, 'L2Regularization', 1e-2);
    struct('epochs', 20, 'dropout', 0.6, 'L2Regularization', 1e-2);
    struct('epochs', 30, 'dropout', 0.7, 'L2Regularization', 1e-2);
    struct('epochs', 40, 'dropout', 0.8, 'L2Regularization', 1e-2);
];

% Initialize results array
results = struct();

% Loop through each configuration
for i = 1:numel(configurations)
    config = configurations(i);
    fprintf('Training model %d with epochs=%d, dropout=%.2f, L2Regularization=%.2e\n', ...
        i, config.epochs, config.dropout, config.L2Regularization);

    % Train the neural network with the current configuration
    trainedNetSPN = trainSPN(trainData, trainLabels, validationData, validationLabels, testData, testLabels, classWeights, config.epochs, config.dropout, config.L2Regularization);

    % Predict labels for test data
    predictedLabels = classify(trainedNetSPN, testData);

    % Calculate performance metrics
    accuracy = sum(predictedLabels == testLabels) / numel(testLabels);
    confusionMat = confusionmat(testLabels, predictedLabels);

    % Display results
    disp('Accuracy:');
    disp(accuracy);
    disp('Confusion Matrix:');
    disp(confusionMat);

    % Plot confusion matrix
    plotConfusionMatrix(confusionMat, unique(testLabels));

    % Calculate and display other performance metrics
    [precision, recall, f1Score] = calculateMetrics(confusionMat);
    disp('Precision:');
    disp(precision);
    disp('Recall:');
    disp(recall);
    disp('F1 Score:');
    disp(f1Score);
    
    % Save results for each configuration
    results(i).config = config;
    results(i).accuracy = accuracy;
    results(i).precision = mean(precision);
    results(i).recall = mean(recall);
    results(i).f1Score = mean(f1Score);
end

% Save all results to a file
save('comparisonResults.mat', 'results');

% Helper function to calculate precision, recall, and F1 score
function [precision, recall, f1Score] = calculateMetrics(confMat)
    numClasses = size(confMat, 1);
    precision = zeros(numClasses, 1);
    recall = zeros(numClasses, 1);
    f1Score = zeros(numClasses, 1);
    for i = 1:numClasses
        tp = confMat(i, i);
        fp = sum(confMat(:, i)) - tp;
        fn = sum(confMat(i, :)) - tp;
        precision(i) = tp / (tp + fp);
        recall(i) = tp / (tp + fn);
        f1Score(i) = 2 * (precision(i) * recall(i)) / (precision(i) + recall(i));
    end
end
