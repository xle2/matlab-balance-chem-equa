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
%Creating an expression containing all possible elements from the periodic
%table
%using 'regrex' to compare the input string and the 'elements' expression
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
    
atom = cellfun(@(v)v{1},parts,'UniformOutput',false);
%cellfun applies function to each cell in cell array
%setting UniformOutput to be false so that the cellfun function combines
%the output into cellarray
%this line get the atoms from the first part of 'parts' - the token


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
