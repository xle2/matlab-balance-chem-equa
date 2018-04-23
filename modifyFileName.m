function [ filenameOut ] = modifyFileName( filenameIn )
% ----------------------------------------------------------------------- %
%                                   ABOUT
%modifyFileName sets the name of the result file to be
%'balance_(name_of_input_file)'
%For example, if the user input a file named 'data.xlsx', modifyFilename
%returns 'balanced_data'
%To get to clearly look as to why we need to create this file, check out
%the GUI of the program. The program will write the resulting value into a
%new file with the format 'balance_(name_of_input_file)'

%Start here
% ----------------------------------------------------------------------- %
modify = 'balanced_';

filenameOut = [modify filenameIn];

end

