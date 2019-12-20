function FeSe_BQPI_fitting(data, symdata, pos1, pos2, avg_px,i)


map = data.map;
symmap = symdata.map;

en = data.e * 1000;

k = data.r;

% cut = line_cut_v4(data,pos1,pos2,avg_px);
cut_sym = line_cut_v4(symdata,pos1,pos2,avg_px);

q = cut_sym.r;
cuttest = cut_sym.cut(:,23);

iq = linspace(q(1),q(end),length(q)*10);
ict = interp1(q,cuttest,iq,'pchip');
ict = sgolayfilt(ict,1,45);

% close all;

% for i=1:51
    figure, plot(1:1:length(q),cut_sym.cut(:,i),'k-o',iq, ict, 'r');
    title([num2str(en(i)),' meV'])
% end

% figure, hold on
% for i=1:22
%     plot(q, (cut_sym.cut(:,i)/mean(cut_sym.cut(:,i)))+(i-1)*0.4,'k','LineWidth', 2)
% end
% hold off
% 
% cc = 0;
% figure, hold on
% for i=30:51
%     plot(q, (cut_sym.cut(:,51 - (i-30))/mean(cut_sym.cut(:,51 - (i-30))))+(cc)*0.4,'k','LineWidth', 2)
%     cc = cc+1;
% end
% hold off
% 
% 
% figure, hold on
% for i=1:22
%     plot(q, (cut.cut(:,i)/mean(cut.cut(:,i)))+(i-1)*0.4,'k','LineWidth', 2)
% end
% hold off
% 
% cc = 0;
% figure, hold on
% for i=30:51
%     plot(q, (cut.cut(:,51 - (i-30))/mean(cut.cut(:,51 - (i-30))))+(cc)*0.4,'k','LineWidth', 2)
%     cc = cc+1;
% end
% hold off

test = 1;
%%
% figure, hold on
% for i=26:46
%     plot(q, (cut_sym.cut(:,i)/mean(cut_sym.cut(:,i)))+(i-1)*0.4,'k','LineWidth', 2)
% end
% hold off
% 
% cc = 0;
% figure, hold on
% for i=56:76
%     plot(q, (cut_sym.cut(:,76 - (i-56))/mean(cut_sym.cut(:,76 - (i-56))))+(cc)*0.4,'k','LineWidth', 2)
%     cc = cc+1;
% end
% hold off
% 
% 
% figure, hold on
% for i=26:46
%     plot(q, (cut.cut(:,i)/mean(cut.cut(:,i)))+(i-1)*0.4,'k','LineWidth', 2)
% end
% hold off
% 
% cc = 0;
% figure, hold on
% for i=56:76
%     plot(q, (cut.cut(:,76 - (i-56))/mean(cut.cut(:,76 - (i-56))))+(cc)*0.4,'k','LineWidth', 2)
%     cc = cc+1;
% end
% hold off


end
