function structResult = countAtom()
% Clear screen and Variable
% ----------------------------------------------------------------------- %
close all
clear variables
clc

% Explanation
% ----------------------------------------------------------------------- %
%This script returns a structure array holding the numbers of atoms in each
%species of the chemical formulas. 
%The input is taken from a file given by the user. This should be an excel
%file, containing only ONE chemical equation that needs to be balanced. 
%
%EXAMPLE
%
%Given H20  H2  O2 (from the excel file)
%Return 1x3 struct with 2 fields
%       H  O
%       2  1
%       2  0
%       O  2    

%Start here
% ----------------------------------------------------------------------- %

%Example input: {'H2O' 'H2' 'O2'}
filename = input('Please enter a filename: ', 's');
[num,txt,raw] = xlsread(filename);

stringInput = raw;
%get the input from the excel file given by the user

q = cellfun(@structConvert,stringInput,'Uniform',false);
%apply Util_StructConvert to every element of input


atoms = {};
for i = 1:length(q)
    atoms = union(atoms, fields(q{i}));
end
%Union of all atomic species
%returns the combined data from atoms and fields of q (the elements)


for i = 1:length(q(:))
        for j = 1:length(atoms)
            if ~ismember(atoms{j},fields(q{i}))
                q{i}.(atoms{j}) = 0;
            end
        end
end
%Add all atomic species to all structures
%If an element is not present in a formula, assign 0
    %example: 'H2' does not contain O --> assign 0


structResult = reshape([q{:}],size(stringInput));
%Form the structure array to have the same shape as rawData

end