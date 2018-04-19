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

group ='|\(([^\)]*)\)(\d*\.\d+|\d*)|(\d*\.\d+|\d*)';
%in case there is a group
%Example: Ca(OH)2 --> There is 1Ca, 2O, and 2H


% ---------------------------------------------------------------------- %
%                           IGNORE THIS PART
%THIS WORKS FOR CASE WITH NO GROUPS
%IT WAS HARD TO CONTINUE ON BECAUSE OF INDEXING 
%
% u = regexp(string,elements,'tokens');
% 
%     %regexp matches regular expression (case sensitive)
%     %Tokens are portions of the matched text that correspond to portions of the regular expression
%     %'start' returns starting indices of all matches
%     %'end' returns ending indices of all matches
%     %'token' returns text of each captured token
%     
% 
% for i = 1:length(u{1,1})
%     atom(i) = cellfun(@(x)x{i}(1),u,'UniformOutput',false);
%     %Extract the atom from the first part of each token
%      %setting UniformOutput to be false so that the cellfun function combines
%      %the output into cellarray
%   
%     %For example, if string = 'H2O', then tok = 1x2 cell of H and O
%     
%     numAtom(i) = cellfun(@(v)v{i}(2),u,'UniformOutput',false); 
%    
%     %Extract counts from the second part of each token
%     
%     numAtom{i} = str2double(numAtom{i});    %convert to number
%     if isnan(numAtom{i}) == 1
%         numAtom{i} =1;                      %if string is empty, set it equal to 1
%     end
% end
% 
% %this should be r.(char(atom{1}) = numatom{1}
% %               r.(char(atom{2}) = numatom{2}
% %atom needs to be of class char, []
% for j = 1:length(atom)
%     struct.(char(atom{j})) = numAtom{j};
% end

% ---------------------------------------------------------------------- %

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
