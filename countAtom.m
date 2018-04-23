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
%OR type countAtom({'H2O','H2','O2'}) to run

%Start here
% ----------------------------------------------------------------------- %

cellInput = cellInput;

%apply Util_StructConvert to every element of input
for i = 1:length(cellInput)
    q{i} = structConvert(cellInput{i});
end
% q = cellfun(@structConvert,cellInput,'Uniform',false); %this works
% too!!

%Union of all atomic species
%returns the combined data from atoms and fields of q (the elements)
atoms = {};
for i = 1:length(q)
    atoms = union(atoms, fields(q{i}));
end

%Add all atomic species to all structures
%If an element is not present in a formula, assign 0
    %example: 'H2' does not contain O --> assign 0
for i = 1:length(q(:))
        for j = 1:length(atoms)
            if ~ismember(atoms{j},fields(q{i}))
                q{i}.(atoms{j}) = 0;
            end
        end
end

%Form the structure array to have the same shape as rawData
structResult = reshape([q{:}],size(cellInput));

end

function structOne = structConvert(stringInput)

% ---------------------------------------------------------------------- %
%                                   ABOUT
%Util_StructConvert returns a struct. Input of this function is a chemical
%formula 'string'
%To call Util_StructConvert, type Util_StructConvert('name_of_chemical')
%Example: Util_StructConvert('CH4')   
  %This returns a struct holding the numbers of atoms in each species
  % C:  1
  % H:  4
% ---------------------------------------------------------------------- %
%                            SOULTION APPROACH
%The idea is to split each elements and their atom counts accordingly
 %For example, if the program is given CH4, it would first split the string
 %into 'C' 'H' '4'
 %Then from there, putting them into a structure
% ---------------------------------------------------------------------- %
%creating an expression containing all possible elements from the periodic
%table
%using 'regrex' to compare the input string and the 'elements' expression
 %this will returns token for element AND a number
%the '(\d*\.\d+|\d*)' denotes number

elements = ['(A[lrsgutcm]|B[eraihk]?|C[aroudlsnemf]?|D[bsy]|E[urs]|', ...
                'F[erlm]?|G[aed]|H[efgso]?|I[nr]?|K[r]?|L[ivaur]|', ...
                'M[gnotcd]|N[eaibhdpo]?|O[sg]?|P[dtbormau]?|R[buhenafg]|', ...
                'S[icernbgm]?|T[icealsbmh]|U|V|W|X[e]|Y[b]?|Z[nr])',...
                '(\d*\.\d+|\d*)']; %'\d*' -> matches any number of consecutive digits
                                   %'\d*' -> matches any number of
                                     %consecutive digits and match 1 or more
                                     %times consecutively
  %'expr?' -> lazy expression: match as few characters as necessary; 0 times or 1 time
  %'expr1|expr2' -> match expression expr1 or expression expr2; if there is a
   %match with expr1, then expr2 is ignore

   
group ='|\(([^\)]*)\)(\d*\.\d+|\d*)';   
% group ='|\(([^\)]*)\)(\d*\.\d+|\d*)|(\d*\.\d+|\d*)';
%match parenthesis followed by a number
%This is for case of a group
%the first expression '|\(([^\)]*)\)(\d*\.\d+|\d*)' search for parenthesis
%Example: Ca(OH)2 --> There is 1Ca, 2O, and 2H


parts = regexp(stringInput,[elements,group],'tokens');
%match the input with the expressions denoted in elements and group
%elements: match an element with a number that follows
%group: match parenthesis with a number that follows
%return the token
%for example, if the string is 'Ca(OH)2', 'parts' would have 2 cells
 %1x2 cell with Ca and ''
 %1x2 cell with OH and 2

%if parts is empty, it means that the input string did not match the expression
%therefore, display error message
if isempty(parts) == 1
    disp('There is no such element. Please check your input');
    %then stop the program
    return
end
    
atom = cellfun(@(v)v{1},parts,'UniformOutput',false);
%get the atoms from the first part of 'parts' - the token
%setting UniformOutput to be false so that the cellfun function combines
%the output into cellarray

numAtom = cellfun(@(v)v{2},parts,'UniformOutput',false);
%Extract counts from the second part of each token
numAtom = str2double(numAtom);
%convert to doubles
numAtom(isnan(numAtom)) = 1;
%set the count is empty, set equals to 1

structOne = struct([]); 
%initializing an empty struct

%making the structure    
for i = 1:length(parts) %loop over the parts
    if strcmp(atom{i},regexp(atom{i},elements,'match')) == 1
        %check if the atom matches exactly an with an element
        %if it is, make a struct
        %if the field already existed, add onto it
        %otherwise, add another field
        if isfield(structOne,atom{i})
            structOne.(atom{i}) = structOne.(atom{i}) + numAtom(i);
        else
            structOne(1).(atom{i}) = numAtom(i);
        end
    else
        %if the atom does NOT match exactly with an element, that must be a
        %group
        %here, a recursion is carry out to find how many atoms there are in
        %that group
        recursive = structConvert(atom{i});
        f = fields(recursive);
        for j = 1:length(f)
            if isfield(structOne,f{j})
                structOne.(f{j}) = structOne.(f{j}) + numAtom(i)*recursive.(f{j});
                %this is just like the one for case of single element
                %except we would need to multiply in the number for every
                %elements in the parenthesis
            else
                structOne(1).(f{j}) = numAtom(i)*recursive.(f{j});
            end
        end
    end
end
      
end
