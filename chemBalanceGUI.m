function [ output_args ] = chemBalanceGUI( input_args )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
figure;
handles.label = uicontrol('Style','text','unit','normalize','Position',...
    [0,.35,.25,.2],'fontsize',14,'String','Original File');

handles.fileIn = uicontrol('Style','edit','unit','normalize','Position',...
    [.25,.45,.3,.15],'string','');

handles.pbSelect = uicontrol('Style','pushbutton','units','normalized',...
    'Position',[.62,.45,.3,.15],'String','Select File','callback',@select);

handles.fileOut = uicontrol('Style','edit','unit','normalize','Position',...
    [.25,.25,.3,.15],'String',' ');

handles.pbProcess = uicontrol('Style','pushbutton','units','normalized',...
    'Position',[.62,.25,.3,.15],'String','Process','callback',@process);


set(0,'UserData',handles); %request that these objects be kept track of

    function [] = select(~,~) %takes 2 input, produces no output
        h = get(0,'UserData');
        fileName = uigetfile('*.xlsx');
        set(h.fileIn, 'string',fileName);
        newFileName = modifyFileName(fileName);
        set(h.fileOut,'string',newFileName);
    end

    function [] = process(~,~)
        h = get(0,'UserData');
        fileName = get(h.fileIn,'string');
        chemBalance(fileName);
        winopen(modifyFileName(fileName));
    end


end

