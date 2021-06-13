% 2020-6-27 YXC



fname = 'C:\Users\chong\Documents\MATLAB\STMdata\Nanonis NbSe2\VClinecut\20200404_0.1T_into_vortex_of_0403122_001.3ds';

% figure,
% for i=1:40
%     [~,t]=load3ds(fname,i-1);
%     plot(t(:,2),'k');
%     hold on
% end



%%
% [h1,t,p]=load3ds(fname,1);
% 
% stop=0;
% i=2;
% while stop==0
%     [h2,t2,p2]=load3ds(fname,i);
%     if sum(t2(:,2)-t(:,2))==0 || i>50000
%         stop=1;
%     end
%     i=i+1
% end
% 
% 
% figure,
% plot(t(:,2),'k');hold on;
% plot(t2(:,2),'k');
% 

%% 

% dd = zeros(939,241,2);
% dp = zeros(939,11);
% pa = zeros(939,1);
% 
% for i=1:939
%     [~,dat,par,data_pos] = load3ds(fname,i-1);
%     dd(i,:,:) = reshape(dat,1,[],2);
%     dp(i,:) = reshape(par,1,[]);
%     pa(i) = data_pos;
% 
% end
% % figure,plot(test)

%% brute force this shit for now
% d is the raw data
s= size(d,1);

mark = 253;
currentofset = 241;

chunk=241*2+11;

% figure,
npoints = 241;

nchunks = floor((s-mark-1)/chunk);
linecut = zeros(nchunks,241);
for i=1:nchunks
    
    m1 = mark;
    m2 = mark+npoints-1;
%     plot(d(m1:m2));
    title(strcat('points ',num2str(m1),' to ',num2str(m2)));
    
    mark = mark+chunk;
    linecut(i,:) = reshape(d(m1:m2),1,[]);
    
end


cut.cut = linecut;
cut.e = map.e;


