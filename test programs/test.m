 q=0;s=0;
 count = 0;
 while ~isempty(q)
     if count ==2
         return
     end
    [x1,y1]=ginput(1)
    count = count +1;
    %plot([x x1],[y y1],'b.-');
    hold on
    q=x1;s=y1;
 end

% [filename,pathname]=uigetfile('*.txt','Select signal data file');
%[filename,pathname]=uigetfile('','Select signal data file');