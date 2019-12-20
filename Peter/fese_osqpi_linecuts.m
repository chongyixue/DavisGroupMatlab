%% line-cut through OS T-matrix q_x

l_cut_data = line_cut_v3(JDOS_qspace_os_pub,[1, 182],[375, 182],0);
cc = 1;

for i = -5:5
    l_cut = line_cut_v3(JDOS_qspace_os_pub,[1, 188+i],[375, 188+i],0);
    l_cut_data.cut = (l_cut_data.cut + l_cut.cut);
    cc = cc + 1;
end

close all;

l_cut_data.cut = l_cut_data.cut / cc;

ncut = l_cut_data.cut;

[lx, ly] = size(ncut);

 for i=1:ly
     dum1 = max(l_cut_data.cut(:,i));
     ncut(:,i) = ncut(:,i)/dum1;
 end

figure, imagesc(l_cut_data.r,l_cut_data.e,ncut')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q_x [1/A]','FontSize',16);
xlim([-0.5, 0.5])
ylabel('E [eV]','FontSize', 16);

%% line-cut through OS T-matrix q_y
% 
% l_cut_data = line_cut_v3(JDOS_qspace_os_pub,[182, 1],[182, 375],0);
% cc = 1;
% 
% for i = -5:5
%     l_cut = line_cut_v3(JDOS_qspace_os_pub,[188+i, 1],[188+i, 375],0);
%     l_cut_data.cut = (l_cut_data.cut + l_cut.cut);
%     cc = cc + 1;
% end
% 
% close all;
% 
% l_cut_data.cut = l_cut_data.cut / cc;
% 
% ncut = l_cut_data.cut;
% 
% [lx, ly] = size(ncut);
% 
%  for i=1:ly
%      dum1 = max(l_cut_data.cut(:,i));
%      ncut(:,i) = ncut(:,i)/dum1;
%  end
% 
% figure, imagesc(l_cut_data.r,l_cut_data.e,ncut')
% set(gca,'YDir','normal')   
% set(gca, 'FontSize', 16);
% xlabel('q_y [1/A]','FontSize',16);
% xlim([-0.5, 0.5])
% ylabel('E [eV]','FontSize', 16);


%% line-cut through equal quasiparticle weights T-matrix q_x

% l_cut_data = line_cut_v3(JDOS_qspace_pub,[1, 182],[375, 182],0);
% cc = 1;
% 
% for i = -5:5
%     l_cut = line_cut_v3(JDOS_qspace_pub,[1, 188+i],[375, 188+i],0);
%     l_cut_data.cut = (l_cut_data.cut + l_cut.cut);
%     cc = cc + 1;
% end
% 
% close all;
% 
% l_cut_data.cut = l_cut_data.cut / cc;
% 
% ncut = l_cut_data.cut;
% 
% [lx, ly] = size(ncut);
% 
%  for i=1:ly
%      dum1 = max(l_cut_data.cut(:,i));
%      ncut(:,i) = ncut(:,i)/dum1;
%  end
% 
% figure, imagesc(l_cut_data.r,l_cut_data.e,ncut')
% set(gca,'YDir','normal')   
% set(gca, 'FontSize', 16);
% xlabel('q_x [1/A]','FontSize',16);
% xlim([-0.5, 0.5])
% ylabel('E [eV]','FontSize', 16);

%% line-cut through equal quasiparticle weights T-matrix q_y

% l_cut_data = line_cut_v3(JDOS_qspace_pub,[182, 1],[182, 375],0);
% cc = 1;
% 
% for i = -5:5
%     l_cut = line_cut_v3(JDOS_qspace_pub,[188+i, 1],[188+i, 375],0);
%     l_cut_data.cut = (l_cut_data.cut + l_cut.cut);
%     cc = cc + 1;
% end
% 
% close all;
% 
% l_cut_data.cut = l_cut_data.cut / cc;
% 
% ncut = l_cut_data.cut;
% 
% [lx, ly] = size(ncut);
% 
%  for i=1:ly
%      dum1 = max(l_cut_data.cut(:,i));
%      ncut(:,i) = ncut(:,i)/dum1;
%  end
% 
% figure, imagesc(l_cut_data.r,l_cut_data.e,ncut')
% set(gca,'YDir','normal')   
% set(gca, 'FontSize', 16);
% xlabel('q_y [1/A]','FontSize',16);
% xlim([-0.5, 0.5])
% ylabel('E [eV]','FontSize', 16);

%% line-cut through data q_x

% l_cut_data = line_cut_v3(obj_60721a00_F_FT_pub,[1, 50],[104, 50],0);
% cc = 1;
% 
% for i = -2:2
%     l_cut = line_cut_v3(obj_60721a00_F_FT_pub,[1, 53+i],[104, 53+i],0);
%     l_cut_data.cut = (l_cut_data.cut + l_cut.cut);
%     cc = cc + 1;
% end
% 
% close all;
% 
% l_cut_data.cut = l_cut_data.cut / cc;
% 
% ncut = l_cut_data.cut;
% 
% [lx, ly] = size(ncut);
% 
%  for i=1:ly
%      dum1 = max(l_cut_data.cut(:,i));
%      ncut(:,i) = ncut(:,i)/dum1;
%  end
% 
% figure, imagesc(l_cut_data.r,l_cut_data.e,ncut')
% set(gca,'YDir','normal')   
% set(gca, 'FontSize', 16);
% xlabel('q_x [1/A]','FontSize',16);
% xlim([-0.5, 0.5])
% ylabel('E [eV]','FontSize', 16);
% 

%% line-cut through data q_y

% l_cut_data = line_cut_v3(obj_60721a00_F_FT_pub,[50, 1],[50, 104],0);
% cc = 1;
% 
% for i = -2:2
%     l_cut = line_cut_v3(obj_60721a00_F_FT_pub,[53+i, 1],[53+i, 104],0);
%     l_cut_data.cut = (l_cut_data.cut + l_cut.cut);
%     cc = cc + 1;
% end
% 
% close all;
% 
% l_cut_data.cut = l_cut_data.cut / cc;
% 
% ncut = l_cut_data.cut;
% 
% [lx, ly] = size(ncut);
% 
%  for i=1:ly
%      dum1 = max(l_cut_data.cut(:,i));
%      ncut(:,i) = ncut(:,i)/dum1;
%  end
% 
% figure, imagesc(l_cut_data.r,l_cut_data.e,ncut')
% set(gca,'YDir','normal')   
% set(gca, 'FontSize', 16);
% xlabel('q_y [1/A]','FontSize',16);
% xlim([-0.5, 0.5])
% ylabel('E [eV]','FontSize', 16);
