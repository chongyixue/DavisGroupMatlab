
%Plot average spectrum from different maps.
%2017/10/26
%Yi Xue Chong



%L = topleft, B = bottomright

clear data;

data(1) = read_map_v6(1,'71123a00.1fl')
data(2) = read_map_v6(1,'71120a08.1fl')
% data(1) = obj_71123a00_G; %100mT, L
% data(2) = obj_71120a08_G; %100mT, R
% data(11) = obj_71101A00_G; %8.5T different map
% data(11) = obj_70914A00_G; %0T

% offset = {0,0.24,-0.06,0.34,1.43,-0.33,0.64,0.81,1.03};
offset = {0,0,0,0,0,0,0,0,0,0,0};



% color = {[0,0,1],[0,0.3,0.7],[1,0,0],[0.8,0.2,0],[0,0.9,0.1],[0.1,0.9,0],[0.5,0.5,0]};
% color = {[0,0,1],[0,0,1],[1,0,0],[1,0,0],[0,1,0],[0,1,0],[0.3,0.3,0.4],[0.5,0.5,0],[0.3,0.3,0.4],[0,0,1]};
frac = 1/(ceil(length(data)/3));


clear xdata;
clear ydata;
clear errordata;

figure,
hold on
for n=1:length(data)
    
    %set color
    scale = 1/ceil(length(data));
    R = scale*(n-1);
    B = 1-R;
    G=0;
    

    
    k=4;
    if n>1
        yold = y;
    end
    [x,y,datstd]=avg_spectrum_data(data(n));
    
    ymin = min(y);
    ymax = max(y);
    range =ymax-ymin;
    
    %make the k^th point the same
    %[~,k]=max(y(1:11));
    if n~=1
        offset{n} = offset{n-1}+yold(k)-y(k);
    end
    
    if n==length(data)
        R=0;
        G=0;
        B=0;
%         x=x-0.17;
    end
    
      %  errorbar(x,y+offset{n},datstd,'color',color{n});
    errorbar(x,(y+offset{n}),datstd,'color',[R,G,B]);
%     errorbar(x,(y-ymin)/range,datstd,'color',[R,G,B]);
    hold on
    % xdata(n,:)=x;
    % ydata(n,:)=y;
    % errordata(n,:)=datstd;
end

%add pointspectra data
[avg,energy] = read_pointspectra3('71122a05',-5.5);
plot(energy,avg,'color',[0.6,0,0.2])

[avg,energy] = read_pointspectra3('71122a01',-5);
plot(energy,avg,'color',[0.5,0,0.3])

[avg,energy] = read_pointspectra3('71121a07',-4.5);
plot(energy,avg,'color',[0.4,0,0.4])

[avg,energy] = read_pointspectra3('71121a04',6);
plot(energy,avg,'color',[0.3,0,0.5])


title('Average Spectrum');
xlabel('E [meV]');
ylabel('dI/dV(S)');
legend('-6mT','3mT','-5.5mT','-5mT','-4.5mT','6mT');
hold off








