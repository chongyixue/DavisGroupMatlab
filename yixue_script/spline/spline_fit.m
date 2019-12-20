%2018-10-9
% YXC
% WILL plot unless something is put into varargin
% red dots is for "gapedge" position - only makes sense if order is 1
% varargout=-1 tells  a bad fit (more than 4 times 0-crossing for order 1
% 2018-10-12 added order 0 to fit coherence peak 

function [spline_x,spline_y,dif,leftgap,rightgap,varargout] = spline_fit(map,xpix,ypix,fitorder,maxgap,varargin)
order = fitorder;
% maxgap = 0.15;
energy = squeeze(map.e).*1000;
avg = squeeze(map.map(ypix,xpix,:));
pp = spline(energy,avg);
spline_x = linspace(energy(1),energy(end),1001);
spline_y = ppval(pp,spline_x);

% order = 1;
if order == 1 || order == 0
    order = 1;
    color = [0.5 0 1];
else
    color = [1 0 0.5];
end
fitlegend = 'fitted gap';

dif = diff(spline_y,order);
multiply = 0.5*max(abs(spline_y))/max(abs(dif));


[~,leftindex]=min(abs(spline_x+maxgap));
[~,rightindex]=min(abs(spline_x-maxgap));
middleindex = (leftindex+rightindex)/2;
[~,leftedge_index] = min(dif(leftindex:middleindex)) ;
if order == 1
    if fitorder == 0
        [~,leftedge_index] = max(spline_y(leftindex:middleindex)) ;
        [~,rightedge_index] = max(spline_y(middleindex:rightindex));
        
        last = 0; crossings = 0;
        for p=leftindex:rightindex
            if dif(p+order)*last < 0
                crossings = crossings + 1;
            end
            last = dif(p+order);
        end
        if crossings>4
            varargout{1} = -1;
        else
            varargout{1} = +1;
        end
        
    else
        
        [~,rightedge_index] = max(dif(middleindex:rightindex));
        last = 0; crossings = 0;
        for p=leftindex:rightindex
            if dif(p+order)*last < 0
                crossings = crossings + 1;
            end
            last = dif(p+order);
        end
        if crossings>4
            varargout{1} = -1;
        else
            varargout{1} = +1;
        end
    end
else
    [~,rightedge_index] = min(dif(middleindex:rightindex));
end
leftedge_index = leftedge_index+ order + leftindex;
rightedge_index = rightedge_index + order + middleindex;%diff offsets the indices
leftgap = spline_x(leftedge_index);
rightgap = spline_x(rightedge_index);
avggap = (rightgap-leftgap)*0.5;

if nargin==5
    figure()
    a=plot(energy,avg,'bo');
    hold on;
    b=plot(spline_x,spline_y,'k','LineWidth',1);
    
    c=plot(spline_x(order+1:end),dif*multiply,'color',color);
    title(['spline for pixels (' num2str(xpix) ', ' num2str(ypix) ') and diff order ' num2str(order)])
    ymax = max(spline_y)*1.2;
    ymin = min(dif)*multiply;
    gap = 0.2;
    d=plot([gap gap],[ymin ymax],'color',[0.1 0.1 0.1 0.4],'LineWidth',8);
    plot([-gap -gap],[ymin ymax],'color',[0.1 0.1 0.1 0.4],'LineWidth',8)
    ylim([ymin ymax])
    
    e=plot([leftgap leftgap],[ymin ymax],'color',[0 0 1 0.4],'LineWidth',8);
    plot([rightgap rightgap],[ymin ymax],'color',[0 0 1 0.4],'LineWidth',8)
    
%     e=plot(spline_x(leftedge_index),0,'ko');
%     plot(spline_x(rightedge_index),0,'ko');
    xlabel('mV')
    legend([a,b,c,d,e],'data', 'spline','diff','expected gap',[fitlegend num2str(avggap) 'mV' ],'Location','southeast')

end



end