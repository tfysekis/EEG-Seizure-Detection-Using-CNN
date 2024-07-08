function netSPN = createSPN(trainLabels, classWeights, dropout)
    % Define the neural network architecture with configurable dropout
    netSPN = [
        sequenceInputLayer(1, 'MinLength', 4097, 'Name', 'input', 'Normalization', 'zscore')
        convolution1dLayer(5, 1, 'Stride', 2)
        cwtLayer('SignalLength', 2047, 'IncludeLowpass', true, 'Wavelet', 'amor')
        maxPooling2dLayer([5, 10])
        convolution2dLayer([5, 10], 5, 'Padding', 'same')
        maxPooling2dLayer([5, 10])  
        batchNormalizationLayer
        reluLayer
        convolution2dLayer([5, 10], 10, 'Padding', 'same')
        maxPooling2dLayer([2, 4])   
        batchNormalizationLayer
        reluLayer
        flattenLayer
        globalAveragePooling1dLayer
        dropoutLayer(dropout)  % Use the configurable dropout rate
        fullyConnectedLayer(3)
        softmaxLayer
        classificationLayer('Classes', unique(trainLabels), 'ClassWeights', classWeights)
    ];
end
