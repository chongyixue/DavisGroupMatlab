% 2019-6-10 YXC testing lorentzianfit function
% map = invert_map(obj_90415a00_G);
map = obj_90411a00_G;

% first 15 points don't use
map.e = map.e(15:end);
map.map = map.map(:,:,15:end);

[nx,ny,nz]= size(map.map);
x = randi([1,nx])
y = randi([1,ny])

x = 15; y = 37;

peakmV_array = [76.25,87.5,100,140,181.3,202.5,218.8,232.5,245,255,265,273.8,282.5,288.8,0,0,0,0,0,0,0,0,0,0,0];
e_array = [-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10]/1000;


background = 2;
fit_and_plot(map,x,y,background,peakmV_array);

% 
% spec = squeeze(map.map(y,x,:))';
% en = map.e;
% 
% 
% maxx = max(spec);
% minn = min(spec);
% 
% % background = 0; %no background subtraction
% % [peakenergy_0,~,~,~,~,startmV,endmV] = many_lorentzfit(en,spec,background,'plot');
% % background = 1; %subtract splinefit
% % [peakenergy_1,~,~,~,~,startmV,endmV] = many_lorentzfit(en,spec,background,'plot');
% background =2;
% [peakenergy_2,~,~,p,err,startmV,endmV] = many_lorentzfit(en,spec,background,'plot');
%  



% %initialize matrices
% pmatrix = zeros(3,nx,ny,9,6);
% llmatrix = zeros(3,nx,ny,9);
% errmatrix = zeros(3,nx,ny,9);
% startmVmatrix = zeros(3,nx,ny,9);
% endmVmatrix = zeros(3,nx,ny,9);
% 
% % landaumap = map;
% 
% for method = 1:3
%     backgnd = method-1;
%     for x = 1:nx
% %     for x = 1:3
%         x
%         for y = 1:ny
% %         for y = 1:3
%             spec = squeeze(map.map(y,x,:))';
%             en = map.e;
%             [peakenergy,~,~,p,err,startmV,endmV] = many_lorentzfit(en,spec,backgnd);
%             [n_fitted,~] = size(p);
%             pmatrix(method,x,y,1:n_fitted,:) = p;
%             llmatrix(method,x,y,1:n_fitted) = peakenergy;
%             errmatrix(method,x,y,1:n_fitted) = err;
%             startmVmatrix(method,x,y,1:n_fitted) = startmV;
%             endmVmatrix(method,x,y,1:n_fitted) = endmV;
%         end
%     end
%     
% end  
% 
% 
% 
