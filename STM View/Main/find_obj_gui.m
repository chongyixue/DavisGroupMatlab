function obj_gui = find_obj_gui(varargin)
%2018-9-23 YXC changed this so that it can take 0 inputs

if nargin>0
f = varargin{1};    
% find all open figures
h = evalin('base','findobj(''type'',''figure'')');
% separate out all ones which have a structure element in their guidata
count = 0;
obj_gui = [];
for i = 1:length(h)
    if isstruct(guidata(h(i))) && h(i) ~= f
        count = count + 1;
        obj_gui(count) = h(i);     
    end
end

else
% find all open figures
h = evalin('base','findobj(''type'',''figure'')');
% separate out all ones which have a structure element in their guidata
count = 0;
obj_gui = [];
for i = 1:length(h)
    if isstruct(guidata(h(i)))
        count = count + 1;
        obj_gui(count) = h(i);     
    end
end    
    
end
end