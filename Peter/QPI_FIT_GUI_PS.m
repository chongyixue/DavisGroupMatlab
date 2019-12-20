
function varargout = QPI_FIT_GUI_PS(varargin)
% MYGUI Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% (Leave a blank line following the help.)

%  Initialization tasks
    gfh = figure('Visible','on','Name','QPI_FIT',...
           'Position',[360,500,450,285]);
%  Construct the components
    uich1 = uicontrol(gfh,'Style','PushButton','BackGroundcolor','Black',...
        'ForegroundColor','White','String','Test','Position',[70 70 130 20]);
    
    ah = axes('Parent',gfh,'Position',[.05 .05 .2 .4]);

%  Initialization tasks

%  Callbacks for MYGUI

%  Utility functions for MYGUI

end

