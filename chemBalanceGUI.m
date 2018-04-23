function [ output_args ] = chemBalanceGUI( input_args )
% ----------------------------------------------------------------------- %
%                                   ABOUT
%This is the GUI of the program
%This GUI is set up so that when the user click on the push button 'Select
%File', they would be able to choose a file which contains an UNBALANCED
%equation. When the user has chosen a file, a result file name will be
%generated in the form of 'balance_(input_file_name)'
%When the push button 'Process' is clicked, the program will perform
%calculation. The resulting coeffient will be written into the result excel
%file

%Start here
% ----------------------------------------------------------------------- %
figure;

%create a text box that says 'Orginal File'
handles.label = uicontrol('Style','text','unit','normalize','Position',...
    [0,.35,.25,.2],'fontsize',14,'String','Original File');

%create an edit box where the file name will be displayed after an input
%file is selected by the user
handles.fileIn = uicontrol('Style','edit','unit','normalize','Position',...
    [.25,.45,.3,.15],'string','');

%create a push button 'Select' so that when it is pushed, a window will
%pop up and the user will get to choose an input excel file
handles.pbSelect = uicontrol('Style','pushbutton','units','normalized',...
    'Position',[.62,.45,.3,.15],'String','Select File','callback',@select);

%create an edit box that will display the output file name after an input
%file is selected by the user. This file has the format of 'balance_(input_file_name)
handles.fileOut = uicontrol('Style','edit','unit','normalize','Position',...
    [.25,.25,.3,.15],'String',' ');

%create the 'Process' push button. When pushed, the program will perform
%calculation
handles.pbProcess = uicontrol('Style','pushbutton','units','normalized',...
    'Position',[.62,.25,.3,.15],'String','Process','callback',@process);


set(0,'UserData',handles); %request that these objects be kept track of

%call back for the 'Select' button
    function [] = select(~,~) %takes 2 input, produces no output
        h = get(0,'UserData');
        fileName = uigetfile('*.xlsx'); %choose an excel file
        set(h.fileIn, 'string',fileName); %set the string of the fileIn text box to the name of the choosen file
        newFileName = modifyFileName(fileName); %create the result file name
        set(h.fileOut,'string',newFileName); %set the string of the fileOut text box to the new file name
    end

%call back for the 'Process' button
    function [] = process(~,~)
        h = get(0,'UserData');
        fileName = get(h.fileIn,'string'); %get the input filename
        chemBalance(fileName); %perform calculation with the inputfile
        winopen(modifyFileName(fileName));
    end


end

