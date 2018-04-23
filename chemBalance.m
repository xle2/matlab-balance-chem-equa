function outputFile = chemBalance(inputFile)
% ----------------------------------------------------------------------- %
%                                   ABOUT
%chemBalance returns the coefficients after the balancing. The result will be
%written into an excel file
 %negative values denote reactants
 %positive values denote products
%The input of chemBalance is an excel input file provided the user

%The output file will be in the form of balanced_(inputfilename). This file
%will contain the coefficients after balancing and the molecular weight
%values of each species

%The molecular weights of the species will also be display in the Command Window

%Two graph: before balancing and after balancing will also be displayed


%                                 START HERE
% ----------------------------------------------------------------------- %
%get the input from the excel file given by the user
[num,txt,raw] = xlsread(inputFile);

%assigned the input to the variable cellInput
cellInput = raw;

%perform countAtom to get the structure
r = countAtom(cellInput);
atoms = fields(r);

%perform myMat to get the matrix
A = myMat(r);

%graph the BEFORE 
figure
bar(A')
title('Before balancing')
legend(atoms);
set(gca,'XTickLabel',cellInput)


%perform the linear system Ax=b calculation the find out the coefficient 
%perform -rref because we want negative to symbolize reactants and positive
%to symbolize products
balanced = -rref(null(A)');

%graph the AFTER
figure
bar(abs(balanced))
title('After balancing')
set(gca,'XTickLabel',cellInput)

%calculate the molecular weight
mw = molecularWeight(cellInput);

%writing the result into a text file
%result includes the BALANCED coefficient and the molecular weight of each 
%species in the order that was given
filenameOut = modifyFileName(inputFile);
xlswrite(filenameOut,[balanced;mw]);

end

