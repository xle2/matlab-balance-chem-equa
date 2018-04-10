function balanced = chemBalance()
%negative for reactants
%positive for products

A = myMat();
balanced = -rref(null(A)')';


end