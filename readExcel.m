function cellInput = readExcel( inputExcelFile )
%UTIL_READEXCEL Summary of this function goes here
%   Detailed explanation goes here

%Example input: {'H2O' 'H2' 'O2'}
[num,txt,raw] = xlsread(inputExcelFile);

cellInput = raw;

% filename = input('Please enter a filename: ', 's');
% inputExcelFile = filename;

% [num,txt,raw] = xlsread(inputExcelFile);


end

