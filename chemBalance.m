function outputFile = chemBalance(inputFile)
%chemBalance returns the coefficients after the balancing and write the
%result into an excel file
%negative for reactants
%positive for products
%The input of chemBalance is an excel input file provided the user


%get the input from the excel file given by the user
[num,txt,raw] = xlsread(inputFile);

%assigned the input to the variable cellInput
cellInput = raw;

%perform countAtom to get the structure
r = countAtom(cellInput);

%perform myMat to get the matrix
A = myMat(r);


%perform the linear system Ax=b calculation the find out the coefficient 
balanced = -rref(null(A)');

%writing the result into a text file
filenameOut = modifyFileName(inputFile);
% filename = 'result.xlsx';
csvwrite(filenameOut,balanced);

end

