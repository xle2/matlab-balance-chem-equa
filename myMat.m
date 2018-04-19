function matrixResult = myMat(structIn)
%computes the matrix for the given set of chemical species. The input is a 
%structure array of the numbers of atoms each species have (the structure 
%array obtained from countAtoms)

%Example: H2 + O2 --> H20
%The struct output from countAtom would be in the form of
%  H  O
%  2  0
%  0  2
%  2  1
%myMat will then generate a matrix in the form of 
%  2  0  2  (number of molecules of H in each cell)
%  0  2  1  (number of molecules of O in each cell)
%Solution approach
 %The size of the matrix in this case will be 2x3
 %Flip the fields of the input struct -> this will give the number of
%columns of the matrix
 %The length of the field itself will be the number of row of the matrix

%take the struct from countAtom as an input
r = structIn;

%the size of the struct is 
atoms = fields(structIn);
atoms = atoms';

%creating the matrix, do a loop
N = length(r);
M = length(atoms);
A = zeros(M,N);
for i = 1:M
    A(i,:) = [r(:).(atoms{i})];
end

matrixResult = A;

end