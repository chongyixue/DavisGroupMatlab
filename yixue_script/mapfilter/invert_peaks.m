%courtesy Rahul Sharma 2018-8-31
%Masks everything but selected Gaussian peak areas and inverse FT

obj = fakemap;
map = obj.map;
energy = obj.e;
ft_data = fourier_transform2d_vb(map,'none','complex','ft');
[nr,nc,nk] = size(ft_data);
clear X
clear Y
clear xdata
[X,Y]=meshgrid(1:1:nc,1:1:nr,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;
npeaks = 2;
clear p;
%p contains i and j coordinates of each peak [i;j]
% TiSe2 5nm, 128 px 
% p(1,:) = [64;54];
% p(2,:) = [72;59];
% p(3,:) = [72;69];
% p(4,:) = [64;74];
% p(5,:) = [56;69];
% p(6,:) = [56;59];

% p(1,:) = [64;45];
% p(2,:) = [80;55];
% p(3,:) = [80;73];
% p(4,:) = [64;83];
% p(5,:) = [47;73];
% p(6,:) = [47;55];

% %NbSe2 6nm 128px
% p(1,:) = [64;56];
% p(2,:) = [70;60];
% p(3,:) = [70;68];
% p(4,:) = [64;72];
% p(5,:) = [58;68];
% p(6,:) = [58;60];

% diagoanl 1
% p(1,:) = [127;36];
% p(2,:) = [74,164];


% diagonal2
% p(1,:) = [47;32];
% p(2,:) = [154,171];

% bragg
% p(1,:) = [18;102];
% p(2,:) = [184,101];
% 
% haldpeak
p(1,:) = [91;60];
p(2,:) = [91;122];

%80818a00map
% p(1,:) = [48;104];
% p(2,:) = [154,98];

% p(1,:) = [55;55];
% p(2,:) = [75,75];

gauss_sigma = 5;
gm = 0;
gm_net = 0;
for i=1:npeaks
    x = [1,p(i,1),gauss_sigma,p(i,2),gauss_sigma,0,0];%7-d vector of features that go into twodgauss
    gm = twodgauss(x,xdata);
    gm_net = gm_net+gm;
end
% figure, imagesc(gm_net), axis square
gm_net = repmat(gm_net,[1 1 nk]);
data_masked_net = ft_data.*gm_net;
mat2STM_Viewer(abs(data_masked_net),energy(1),energy(nk),length(energy));
ift_peaks = fourier_transform2d_vb(data_masked_net,'none','real','ift');
mat2STM_Viewer(ift_peaks,energy(1),energy(nk),length(energy));

