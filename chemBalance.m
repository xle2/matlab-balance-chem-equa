function outputFile = chemBalance(inputFile)
% ----------------------------------------------------------------------- %
%                                   ABOUT
%chemBalance returns the coefficients after the balancing. The result will be
%written into an excel file
%negative values denote reactants
%positive values denote products
%The input of chemBalance is an excel input file provided the user


%Start here
% ----------------------------------------------------------------------- %
%get the input from the excel file given by the user
[num,txt,raw] = xlsread(inputFile);

%assigned the input to the variable cellInput
cellInput = raw;

%perform countAtom to get the structure
r = countAtom(cellInput);

%perform myMat to get the matrix
A = myMat(r);

%graph the BEFORE 
figure
bar(A')
title('Before balancing')
legend(atoms);
set(gca,'XTickLabel',cellInput)


%perform the linear system Ax=b calculation the find out the coefficient 
balanced = -rref(null(A)');

% graphing
figure
bar(abs(balanced))
title('After balancing')
set(gca,'XTickLabel',cellInput)

%calculate the molecular weight
molecularWeight(cellInput)

%writing the result into a text file
filenameOut = modifyFileName(inputFile);
% filename = 'result.xlsx';
xlswrite(filenameOut,balanced);


end

