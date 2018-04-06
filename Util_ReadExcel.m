function equationArray = Util_ReadExcel( inputExcelFile )
%UTIL_READEXCEL Summary of this function goes here
%   Detailed explanation goes here

%Example input: {'H2O' 'H2' 'O2'}
% filename = input('Please enter a filename: ', 's');

% TODO - delete this line in production
inputExcelFile = 'data.xlsx'

[num,txt,raw] = xlsread(inputExcelFile);

equationArray = raw;
end

