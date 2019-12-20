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

function graph_plot(x,y,datstd,varargin)
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

% for i=1:length(x)
%     lowstd(i) = y(i)-datstd(i);
%     higstd(i) = y(i)+datstd(i);
%     if lowstd(i) < 0
%         lowstd(i) =0;
%     end
% end
    
% plot(xvar,y,[col_mark '.-'],xvar,higstd,'k.-',xvar,lowstd,'k.-');
errorbar(xvar,y,datstd,[col_mark '.-']);
legend('ave. spec. w/ stdev.');
% plot(xvar,y,[col_mark 'o-'],'LineWidth',2); 
% legend('average spectrum');
xlabel('mV');

end
