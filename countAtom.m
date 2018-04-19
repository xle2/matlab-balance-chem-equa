function structResult = countAtom(cellInput)


% ----------------------------------------------------------------------- %
%                       CLEAR SCREEN AND VARIABLES
% close all
% clear variables
% clc

% ----------------------------------------------------------------------- %
%                                   ABOUT
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

% switch class(varargin)
%     case class(varargin) == 'char' %if the input is a string
%         stringInput = varargin;
%     case isfile(varargin) == 1 %if the input is a file
%         filename = varargin;
%         [num,txt,raw] = xlsread(filename);
%         stringInput = raw;
% end


% q = cellfun(@structConvert,cellInput,'Uniform',false); %this works
% too!!
%apply Util_StructConvert to every element of input


for i = 1:length(cellInput)
    q{i} = structConvert(cellInput{i});
end

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


structResult = reshape([q{:}],size(cellInput));
%Form the structure array to have the same shape as rawData

end