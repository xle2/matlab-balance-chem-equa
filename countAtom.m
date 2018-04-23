function structResult = countAtom(cellInput)

% ----------------------------------------------------------------------- %
%                                   ABOUT
%This script returns a structure array holding the numbers of atoms in each
%species of the chemical formulas. 
%The input is a cell array. The output is a struct 
%Here, 'function' function is used. The countAtom called the function
%structConvert to find the struct of each element. Then countAtom makes a
%big overall struct symbolize every element of the input array
%
%EXAMPLE
%
%Given {'H20','H2','O2'}
%Return 1x3 struct with 2 fields
%       H  O
%       2  1
%       2  0
%       O  2 
%Type countAtom({'H2O','H2','O2'}) to run

%                                 START HERE
% ----------------------------------------------------------------------- %

%Apply structConvert to every element of input
for i = 1:length(cellInput)
    combineStruct{i} = structConvert(cellInput{i});
end

%Set union of two array with no repetition
%returns the combined data from atoms and the fields of combineStruct (the
%elements) with no repetition
atoms = {};
for i = 1:length(combineStruct)
    atoms = union(atoms, fields(combineStruct{i}));
end

%Add all atomic species to all structures
%If an element is not present in a formula, assign 0
    %example: 'H2' does not contain O --> assign 0
for i = 1:length(combineStruct(:))
        for j = 1:length(atoms)
            if ~ismember(atoms{j},fields(combineStruct{i}))
                combineStruct{i}.(atoms{j}) = 0;
            end
        end
end

%Form the structure array to have the same shape as cellInput
structResult = reshape([combineStruct{:}],size(cellInput));

end

function structOne = structConvert(stringInput)

% ---------------------------------------------------------------------- %
%                                   ABOUT
%structConvert returns a struct. Input of this function is a chemical
%formula 'string'
%To call structConvert, type structConvert('name_of_chemical')
%Example: structConvert('CH4')   
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
%                                START HERE
%First of all, create an expression containing all possible elements from the periodic
%table
%Then, use 'regrex' to compare the input string and the expression
 %this will returns token for element AND a number
%the '(\d*))' denotes number

%match letter(s) followed by a number
elements = ['(Al|Ar|As|Ag|Au|At|Ac|Am|Db|Ds|Dy|Er|Er|Es|Ga|Ge|Gd|Li|Lv|',...
    'La|Lu|Lr|Mg|Mn|Mo|Mt|Mc|Md|Rb|Ru|Rh|Re|Rn|Ra|Rf|Rg|Ti|Tc|Te|Ta|'...
    'Tl|Ts|Tb|Tm|Th|U|V|W|Xe|Zn|Zr|'...
    'B[eraihk]?|C[aroudlsnemf]?|F[erlm]?|H[efgso]?|K[r]?|N[eaibhdpo]?|'...
    'O[sg]?|P[dtbormau]?|S[icernbgm]?|Y[b]?)'...
    '(\d*)'];
  %'expr1|expr2' -> match expression expr1 or expression expr2; if there is a
   %match with expr1, then expr2 is ignore
  %'expr?' -> match the expression when it occurs 0 times or 1 time
   %In case of elements like C,Ca,Cr, if the user input Ca2O, we want to
   %token Ca, not C; if the user input CH4, we want to token C, not Ca or
   %Cr,... therefore, use bracket [] to indicate match any one of the
   %characters listed
   %C[aroudlsne]? %match anyone of the characters listed

   
%match parenthesis followed by a number
%This is for case of a group
%the first expression '|\(([^\)]*)\)(\d*\.\d+|\d*)' search for parenthesis
%Example: Ca(OH)2 --> There is 1Ca, 2O, and 2H   
group = ('|\(([^\)]*)\)((\d*))');      
%match letter followed by parenthesis and then closed with parenthesis '\(\)'
%match the expression above and followed by a number '(\d*\.\d+|\d*)'
%[^\)] any character not contained within the brackets

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
    %throw an error and display error message
    msg = 'There is no such element. Please check your input';
    %then stop the program
    error(msg)
       
end

%Get the atoms from the first part of 'parts' - the token
atom = cellfun(@(v)v{1},parts,'UniformOutput',false);
%cellfun applies function to each cell in cell array
%setting UniformOutput to be false so that the cellfun function combines
%the output into cellarray


%Extract counts from the second part of each token
numAtom = cellfun(@(v)v{2},parts,'UniformOutput',false);
numAtom = str2double(numAtom);
%convert to doubles
numAtom(isnan(numAtom)) = 1;
%set the count is empty, set equals to 1


%initializing an empty struct
structOne = struct([]); 

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
