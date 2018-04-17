function balanced = chemBalance()
%negative for reactants
%positive for products
%The input of chemBalance is the output matrix from myMat

%taking input from myMat
A = myMat();

%perform the linear system Ax=b calculation the find out the coefficient 
balanced = -rref(null(A)')';
T = array2table(balanced);

%writing the result into a text file
filename = 'result.txt';
writetable(T,filename);

end