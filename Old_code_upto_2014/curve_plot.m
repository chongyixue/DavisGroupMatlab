%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: Plotting x vs y with the option of curve color,marker, 
%                   (varargin{1}) and plot title (varargin{2})
% and title for plot
%
% ALGORITHM: Use plot function from MATLAB
%
% CODE HISTORY
%
% 100916 MHH Created

function curve_plot(x,y,varargin)
in_len = length(varargin);
if ~isnumeric(x)
    xvar = 1:length(y);
else 
    xvar = x;
end

if (in_len == 1 && ~isempty(varargin{1}))    
    col_mark = varargin{1};
    title = '';
elseif in_len == 2 && ~isempty(varargin{1}) && ~isempty(varargin{2})
    col_mark = varargin{1};
    title = varargin{2};
elseif isempty(varargin)
    col_mark = 'b';
    title = '';
else    
    col_mark = 'b';
    title = varargin{2};
end
figure('Position',[150 150 400 400],'Name',title);
plot(xvar,y,col_mark); 

end
