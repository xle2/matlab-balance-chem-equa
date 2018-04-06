function r = countAtoms(inputfilename)
A = readtable(inputfilename); 
cell_input = table2cell(A); 
disp(cell_input)


temporaryArray = {};
for i = 1:length(q(:))
   temporaryArray = union(atoms, fields(q{i}));
end

letterArray = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',... 
               'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',... 
               'W', 'X', 'Y', 'Z'};
lowerCase = lower(letterArray); %still class cell
numberArrray = {'1','2','3','4','5','6','7','8','9','10',...
                '11','12','13','14','15','16','17','18','19','20',...
                '21','22','23','24','25','26','27','28','29','30',...
                '31','32','33','34','35','36','37','38','39','40'};
            
atomArray = {'CH4','O2','CO2','H20'};
 %take each element from atomArray; atomArray{1} = 'CH4'
 %split each element into individual; letterArray = 'C','H','4'
 %loop through and get them into temporary structures/array
temporaryArray = {};
for i = 1:length(letterArray)
    want = atomArray{i}(i);
    if want == letterArray{i}
        temporaryArray{i} = {b};
    end         
end

end

