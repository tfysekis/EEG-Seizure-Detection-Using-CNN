    function dataDir = loadEEGData()
    % Instructions for creating a folder to store EEG data
    disp('Before running this code, create a folder to store your EEG data.');

    % Download link for the EEG data
    disp('Download the required .zip files from the provided link:');
    disp('https://www.upf.edu/web/ntsa/downloads/-/asset_publisher/xvT6E4pczrBw/content/2001-indications-of-nonlinear-deterministic-and-finite-dimensional-structures-in-time-series-of-brain-electrical-activity-dependence-on-recording-regi?inheritRedirect=false&redirect=https://www.upf.edu/web/ntsa/downloads?p_p_id%3D101_INSTANCE_xvT6E4pczrBw%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview%26p_p_col_id%3Dcolumn-1%26p_p_col_count%3D1#.X5Ep-S337UI');

    % Get the current directory
    currentDir = pwd;

    % Set the current directory to the folder containing the script
    scriptPath = which(mfilename);
    scriptDir = fileparts(scriptPath);

    % Create Data directory
    dataDir = fullfile(currentDir, 'Data');
    mkdir(dataDir);

    % Specify the zip files
    zipFiles = {'Z.zip', 'O.zip', 'N.zip', 'F.zip', 'S.zip'};

    % Unzip each file into the Data directory
    for i = 1:length(zipFiles)
        zipFile = zipFiles{i};
        unzip(zipFile, dataDir);
    end
    disp('EEG data has been extracted successfully.');
end

