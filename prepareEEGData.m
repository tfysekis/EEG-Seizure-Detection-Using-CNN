function [trainData, trainLabels, validationData, validationLabels, testData, testLabels] = prepareEEGData()
    % Specify the data directory
    dataDir = fullfile(pwd, 'Data');

    % Create a tabular text datastore to read the data
    tds = tabularTextDatastore(dataDir, "IncludeSubfolders", true, "FileExtensions", ".txt");

    % Extract labels from file names
    labels = filenames2labels(tds.Files, "ExtractBetween", [1 1]);

    % Read EEG data
    eegData = cell(numel(labels), 1);
    ii = 1;
    while hasdata(tds)
        tsTable = read(tds);
        ts = tsTable.Var1;
        eegData{ii} = reshape(ts, 1, []);
        ii = ii + 1;
    end

    % Process labels
    labels3Class = labels;
    labels3Class = removecats(labels3Class, ["F", "N", "O", "S", "Z"]);
    labels3Class(labels == categorical("Z") | labels == categorical("O")) = categorical("Normal");
    labels3Class(labels == categorical("F") | labels == categorical("N")) = categorical("Pre-seizure");
    labels3Class(labels == categorical("S")) = categorical("Seizure");

    % Display summary
    disp('Summary of processed labels:');
    summary(labels3Class);

    % Set seed for reproducibility
    rng(123); % Choose any desired seed value

    % Calculate class weights

    % We need a training set, a test set, and a validation set
    % Using the 70-20-10 method
    % Specify the proportions for training, testing, and validation sets
    trainFraction = 0.7;
    testFraction = 0.2;
    validationFraction = 0.1;

    % Get the total number of samples
    totalSamples = numel(eegData);

    % Calculate the number of samples for each set
    trainCount = round(trainFraction * totalSamples);
    testCount = round(testFraction * totalSamples);
    validationCount = totalSamples - trainCount - testCount;

    % Generate indices for splitting the data
    indices = randperm(totalSamples);
    trainIndices = indices(1:trainCount);
    testIndices = indices(trainCount+1:trainCount+testCount);
    validationIndices = indices(trainCount+testCount+1:end);

    % Create the training, testing, and validation sets
    trainData = eegData(trainIndices);
    trainLabels = labels3Class(trainIndices);

    testData = eegData(testIndices);
    testLabels = labels3Class(testIndices);

    validationData = eegData(validationIndices);
    validationLabels = labels3Class(validationIndices);

    % Display summary of sets
    fprintf('\nSummary of Training Set:\n');
    summary(trainLabels);

    fprintf('\nSummary of Validation Set:\n');
    summary(validationLabels);

    fprintf('\nSummary of Test Set:\n');
    summary(testLabels);

    % Plot EEG data examples
    helperExamplePlot(trainData, trainLabels);
end

function helperExamplePlot(trainDataSPN, trainLabelsSPN)
    % This function is for example use only. It may be changed or
    % removed in a future release.
    %
    % Copyright 2022 The MathWorks, Inc.
    szidx = find(trainLabelsSPN == categorical("Seizure"), 1, "first");
    psidx = find(trainLabelsSPN == categorical("Pre-seizure"), 1, "first");
    nidx = find(trainLabelsSPN == categorical("Normal"), 1, "first");
    Fs = 173.61;
    t = 0:1/Fs:(4097*1/Fs)-1/Fs;
    [scSZ, f] = cwt(trainDataSPN{szidx}, Fs, "amor");
    scSZ = abs(scSZ);
    scPS = abs(cwt(trainDataSPN{psidx}, Fs, "amor"));
    scN = abs(cwt(trainDataSPN{nidx}, Fs, "amor"));
    tiledlayout(3, 2)
    nexttile
    plot(t, trainDataSPN{szidx}), axis tight
    title("Seizure EEG")
    ylabel("Amplitude")
    nexttile
    surf(t, f, scSZ), shading interp, view(0, 90)
    set(gca, "Yscale", "log"), axis tight
    title("Scalogram -- Seizure EEG")
    ylabel("Hz")
    nexttile
    plot(t, trainDataSPN{psidx}), axis tight
    title("Pre-seizure EEG")
    ylabel("Amplitude")
    nexttile
    surf(t, f, scPS), shading interp, view(0, 90)
    set(gca, "Yscale", "log"), axis tight
    title("Scalogram -- Pre-seizure EEG")
    ylabel("Hz")
    nexttile
    plot(t, trainDataSPN{nidx}), axis tight
    title("Normal EEG")
    ylabel("Amplitude")
    xlabel("Time (Seconds)")
    nexttile
    surf(t, f, scN), shading interp, view(0, 90)
    set(gca, "Yscale", "log"), axis tight
    title("Scalogram -- Normal EEG")
    ylabel("Hz")
    xlabel("Time (Seconds)")
end

