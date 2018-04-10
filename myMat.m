function matrixResult = myMat()
%computes the matrix for the given set of chemical species. The input is a 
%structure array of the numbers of atoms each species have (the structure 
%array obtained from countAtoms)
r = countAtom;

atoms = fields(r);
atoms = atoms';

N = length(r);
M = length(atoms);
A = zeros(M,N);
for i = 1:M
    A(i,:) = [r(:).(atoms{i})];
end

matrixResult = A;

end