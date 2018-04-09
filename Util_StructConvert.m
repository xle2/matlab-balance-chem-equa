function struct = Util_StructConvert( string )
%UTIL_STRUCTCONVERT Summary of this function goes here
%   Detailed explanation goes here
%returns token for element AND a number
%the '(\d*\.\d+|\d*)' denotes number
elements = ['(A[lrsgutcm]|B[eraihk]?|C[aroudlsnemf]?|D[bsy]|E[urs]|', ...
                'F[erlm]?|G[aed]|H[efgso]?|I[nr]?|K[r]?|L[ivaur]|', ...
                'M[gnotcd]|N[eaibhdpo]?|O[sg]?|P[dtbormau]?|R[buhenafg]|', ...
                'S[icernbgm]?|T[icealsbmh]|U|V|W|X[e]|Y[b]?|Z[nr])',...
                '(\d*\.\d+|\d*)']; %'\d*' -> matches any number of consecutive digits
                                   %'\d*' -> matches any number of
                                     %consecutive digits and match 1 or more
                                     %times consecutively
  %'expr?' -> 0 times or 1 time
  %'expr1|expr2' -> match expression expr1 or expression expr2; if there is a
   %match with expr1, then expr2 is ignore
   
        
u = regexp(string,elements,'tokens');

    %regexp matches regular expression (case sensitive)
    %Tokens are portions of the matched text that correspond to portions of the regular expression
    %'start' returns starting indices of all matches
    %'end' returns ending indices of all matches
    %'token' returns text of each captured token
    

for i = 1:length(u{1,1})
    atom(i) = cellfun(@(x)x{i}(1),u,'UniformOutput',false);
    %Extract the atom from the first part of each token
     %setting UniformOutput to be false so that the cellfun function combines
     %the output into cellarray
  
    %For example, if string = 'H2O', then tok = 1x2 cell of H and O
    
    numAtom(i) = cellfun(@(v)v{i}(2),u,'UniformOutput',false); 
   
    %Extract counts from the second part of each token
    
    numAtom{i} = str2double(numAtom{i});    %convert to number
    if isnan(numAtom{i}) == 1
        numAtom{i} =1;                      %if string is empty, set it equal to 1
    end
end

%this should be r.(char(atom{1}) = numatom{1}
%               r.(char(atom{2}) = numatom{2}
%atom needs to be of class char, []
for j = 1:length(atom)
    struct.(char(atom{j})) = numAtom{j};
end


end

