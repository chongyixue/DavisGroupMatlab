function imax=find_peak_spectra(e,dos,range,crit_p2,crit_p1, order,output)
% key to results
% comumn 1 : index
% comumn 2 : xdata (e) value
% comumn 3 : exact xdata (e) value
% comumn 4 : ydata (dos) value (at index
% comumn 5 : exact y(dos) value
% comumn 6 : p2
% comumn 7 : p1
%tic
%find 1st round of candidates
[xmax,imax,xmin,imin] = extrema(dos);
imax=sort(imax);

hold off
%output=1;

if output
    plot(e,dos,'w.')
    plot(e,dos,'bo-')
    hold on
    plot(e(imax),dos(imax),'r.')
end

if isempty(imax)
    imax=zeros(1,7);
    return
end

imax=[imax,0*imax,0*imax,0*imax,0*imax,0*imax,0*imax];



% get rid of points too close to end/begining
imax(imax(:,1)>=length(dos)-range |...
    imax(:,1)<=range,:)=[];


if ~any(imax)
    imax=nan(1,7);
    return;
end

% find second round of candidates




% check two criteria: 
% 2nd der has to be neg (or smaller than crit_p2,
% 1st der has to bee small (we do not want too much slope
 imax=aux_imax_polyfit(imax);


% check if they are too close
dimax=diff(imax(:,1));
% if there are more than 2 in a row
ind=find(dimax(:)<=range);
inddel=[];
for k=1:length(ind)
         indtest=find(diff(ind(k:end))==1);
             % try to get back to imax indices
             if output
                 plot(e(imax(ind(k):...
                     1+ind(k)+length(indtest),1)),...
                     dos(imax(ind(k):...
                     1+ind(k)+length(indtest),1)),'g.'); 
             end
             imax(ind(k),1)=...
                 round(mean(imax(ind(k):...
                 1+ind(k)+length(indtest),1)));
             inddel=[inddel,ind(k)+1:1+ind(k)+length(indtest)];
             if output
                 plot(e(imax(ind(k),1)),...
                     dos(imax(ind(k),1)),'k.'); 
             end
             k=k+length(indtest);
end
imax(inddel,:)=[];
if length(inddel)>0
    imax=aux_imax_polyfit(imax);
end

if output
    plot(e(imax(:,1)),dos(imax(:,1)),'r+')   
    hold off
end
imax(:,2)=e(imax(:,1));
%imax(:,4)=dos(imax(:,1));


%imax(:,5)=interp1(e,dos,imax(3));


    


if ~any(imax)
    imax=nan(1,7);
    return;
end

switch order
    case 'none'
        
    case 'abssmall'
        [tmp, ind]=sort(abs(imax(:,2)),'ascend');
        imax=imax(ind(1),:);   
    case 'abslarge'
        [tmp, ind]=sort(-abs(imax(:,3)),'ascend');
        imax=imax(ind(1),:);   
    case 'well'
        [tmp, ind]=sort(-(imax(:,6)),'descend');
        imax=imax(ind(1),:);    
    otherwise
        fff
end




% order function
function imax=aux_imax_polyfit(imax)
    p=nan(3,length(imax(:,1)));
    % get s poly parameters, compares them to crit, and deletes tehm is
    % necesssary.
    for j=1:length(imax(:,1))
        p(:,j)=polyfit(e(imax(j,1)-range:imax(j,1)+range),...
            dos(imax(j,1)-range:imax(j,1)+range),2)';

        if output
            text(e(imax(j,1)),dos(imax(j,1)), ...
                ['\leftarrow '  num2str(-p(1,j),'%2.2e') ' '], ...
             'HorizontalAlignment','left')
             littlee=linspace(...
                 e(imax(j,1)-range),e(imax(j,1)+range),20);
             littledos=polyval(p(:,j),littlee);
             plot(littlee,littledos,'r:')
        end
    end
    inddel=(p(1,:)<=crit_p2).*...
    (abs(p(2,:))<=crit_p1);
    inddel=find(inddel==0);
    if output
        plot(e(imax(inddel,1)),dos(imax(inddel,1)),'c.'); 
    end
    imax(:,6)=p(1,:);
    imax(:,7)=p(2,:);
    imax(:,3)=-p(2,:)./p(1,:)/2; %exact e
    imax(:,4)=-((p(2,:).^2-4*p(1,:).*p(3,:)))./p(1,:)/4; %exact e
    
    imax(inddel,:)=[];
    if output
        plot((imax(:,3)),(imax(:,4)),'r+'); 
    end
    
end

end