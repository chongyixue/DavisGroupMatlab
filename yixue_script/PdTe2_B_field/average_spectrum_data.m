
%Plot average spectrum from different maps.
%2017/10/26
%Yi Xue Chong



%L = topleft, B = bottomright

clear data;

data(5) = obj_71025a14_G; %100mT, L
data(6) = obj_71025a15_G; %100mT, R
data(3) = obj_71026a05_G; %50mT, L
data(4) = obj_71026a07_G; %50mT, R
data(1) = obj_71028a00_G; %10mT, L
data(2) = obj_71028a02_G; %10mT, R
data(7) = obj_71029a05_G; %400mT, C
data(8) = obj_71030a00_G; %400mT, large center
data(9) = obj_71030a08_G; %1T, C
data(10) = obj_71031A06_G; %8.5T,C
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
    yold = y;
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
    erro  rbar(x,(y+offset{n}),datstd,'color',[R,G,B]);
%     errorbar(x,(y-ymin)/range,datstd,'color',[R,G,B]);
    hold on
    % xdata(n,:)=x;
    % ydata(n,:)=y;
    % errordata(n,:)=datstd;
end

title('Average Spectrum');
xlabel('E [meV]');
ylabel('dI/dV(S)');
legend('10mT_{TL}','10mT_{BR}','50mT_{TL}','50mT_{BR}','100mT_{TL}','100mT_{BR}','400mT_{C}','400mT_{120nm}','1T_{C}','8.5T_{C}','0T');
hold off









