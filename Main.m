% Clear screen and Variable
% ----------------------------------------------------------------------- %
close all
clear variables
clc

% Declare global variables
% ----------------------------------------------------------------------- %
dataStructure = 0;
rawData = 0;


% Business Logic
% ----------------------------------------------------------------------- %

% Read Excel File and return raw data
rawData = Util_ReadExcel();
G = cell(1, length(rawData));

for i = 1:length(rawData)
    tempResult = Util_StructConvert(rawData(i));
    elementName = fieldnames(tempResult);
    
    for k = 1:length(tempResult)
       G{i} = tempResult(k);
    end
    
    disp('---- End of One Loop ----')
end


% disp(tempResult.(elementName{1}))