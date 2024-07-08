function plotConfusionMatrix(confMat, classes)
    % Plot confusion matrix
    figure;
    cm = confusionchart(confMat, classes);
    cm.Title = 'Confusion Matrix';
    cm.RowSummary = 'row-normalized';
    cm.ColumnSummary = 'column-normalized';
end
