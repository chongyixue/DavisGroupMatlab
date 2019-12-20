
close all;
clear all;

%% All 3 Tesla maps, load the vortex positions and combine them all in two
%% arrays ThreeTx (x coord.) and ThreeTy (y coord.)
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_04_13\Vortex_050413.mat

ThreeTx=vortex.hresx;
ThreeTy=vortex.hresy;
clear vortex;

load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_06_13\Vortex_050613.mat

ThreeTx=[ThreeTx vortex.hresx];
ThreeTy=[ThreeTy vortex.hresy];
clear vortex;

load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_08_13\Vortex_050813.mat

ThreeTx=[ThreeTx vortex.hresx];
ThreeTy=[ThreeTy vortex.hresy];
clear vortex;

load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_15_13\Vortex_051513.mat

ThreeTx=[ThreeTx vortex.hresx];
ThreeTy=[ThreeTy vortex.hresy];
clear vortex;

load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_23_13\Vortex_052313.mat

ThreeTx=[ThreeTx vortex.hresx];
ThreeTy=[ThreeTy vortex.hresy];
clear vortex;

load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_27_13\Vortex_052713.mat

ThreeTx=[ThreeTx vortex.hresx];
ThreeTy=[ThreeTy vortex.hresy];
clear vortex;

%% All 1 T maps, load the vortex positions and combine them all in two
%% arrays OneTx (x coord.) and OneTy (y coord.)
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_02_13\Vortex_060213.mat

OneTx=vortex.hresx;
OneTy=vortex.hresy;
clear vortex;

%% All 6 T maps, load the vortex positions and combine them all in two
%% arrays SixTx (x coord.) and SixTy (y coord.)
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_12_13\Vortex_061213.mat

SixTx=vortex.hresx;
SixTy=vortex.hresy;
clear vortex;

load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_13_13\Vortex_061313.mat

SixTx=[SixTx vortex.hresx];
SixTy=[SixTy vortex.hresy];
clear vortex;

%% All 8 T maps, load the vortex positions and combine them all in two
%% arrays EightTx (x coord.) and EightTy (y coord.)
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_14_13\Vortex_061413.mat

EightTx=vortex.hresx;
EightTy=vortex.hresy;
clear vortex;

%% All 4 T maps, load the vortex positions and combine them all in two
%% arrays FourTx (x coord.) and FourTy (y coord.)
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_17_13\Vortex_061713.mat

FourTx=vortex.hresx;
FourTy=vortex.hresy;
clear vortex;


%% Get the coordinates of all the vortex cores that are in the highres topo
%% area
clear OneTxx OneTyy ThreeTxx ThreeTyy FourTxx FourTyy SixTxx SixTyy EightTxx EightTyy
clear AllTxx AllTyy
t=1;
for i=1:length(OneTx)
    if OneTx(i) <=327 || OneTx(i) > 512 || OneTy(i) <=0 || OneTy(i) >185
    else
        OneTxx(t)=OneTx(i);
        OneTyy(t)=OneTy(i);
        t=t+1;
    end
end

t=1;
for i=1:length(ThreeTx)
    if ThreeTx(i) <=327 || ThreeTx(i) > 512 || ThreeTy(i) <=0 || ThreeTy(i) >185
    else
       ThreeTxx(t)=ThreeTx(i);
       ThreeTyy(t)=ThreeTy(i); 
       t=t+1;
    end
end

t=1;
for i=1:length(FourTx)
    if FourTx(i) <=327 || FourTx(i) > 512 || FourTy(i) <=0 || FourTy(i) >185
    else
        FourTxx(t)=FourTx(i);
        FourTyy(t)=FourTy(i);
        t=t+1;
    end
end

t=1;
for i=1:length(SixTx)
    if SixTx(i) <=327 || SixTx(i) > 512 || SixTy(i) <=0 || SixTy(i) >185
    else
        SixTxx(t)=SixTx(i);
        SixTyy(t)=SixTy(i);
        t=t+1;
    end
end

t=1;
for i=1:length(EightTx)
    if EightTx(i) <=327 || EightTx(i) > 512 || EightTy(i) <=0 || EightTy(i) >185
    else
        EightTxx(t)=EightTx(i);
        EightTyy(t)=EightTy(i);
        t=t+1;
    end
end

% AllTxx=[OneTxx, ThreeTxx, FourTxx, SixTxx, EightTxx];
% AllTyy=[OneTyy, ThreeTyy, FourTyy, SixTyy, EightTyy];
% 
% 
% AllTxx=[OneTxx];
% AllTyy=[OneTyy];
% 
% AllTxx=[ThreeTxx];
% AllTyy=[ThreeTyy];
% 
% AllTxx=[FourTxx];
% AllTyy=[FourTyy];
% 
% AllTxx=[SixTxx];
% AllTyy=[SixTyy];

AllTxx=[EightTxx];
AllTyy=[EightTyy];

%% Get the high resolution 
% STM_View_v2
% changed contrast of the atomic resolution map
obj_30606A03_T=importdata('C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_06_13\30606A03_T.mat');
Topo=obj_30606A03_T.map;

%% Create meshgrid for fit-function
[X,Y]=meshgrid(1:1:185,1:1:185);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE HOW TO USE MESHGRID - START
% [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
% Z = X .* exp(-X.^2 - Y.^2);  
% figure;
% surf(X,Y,Z)
% EXAMPLE - END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xdata(:,:,1)=X;
xdata(:,:,2)=Y;


%% Upper Right
Topon=Topo(1:185,328:512)-mean(mean(Topo(1:185,328:512)));
Toponm=Topo(1:185,328:512)-mean(mean(Topo(1:185,328:512)));
Toponmm=Toponm;

% Topon=Topo(1:185,328:512);
% Toponm=Topon;
% Toponmm=Topon;

% for z=1:100
    for i =1:length(AllTxx)
        x0 = [1; AllTxx(i)-327; 3; AllTyy(i); 3; 0; 0];
        % Height, x-pos, x-var, y-pos, y-var, offset, angle for rotation(just zero here all the
        % time)
        x2 = round(rand(1)*185);
        x3 = round(rand(1)*185);
        x1 = [1; x2; 3; x3; 3; 0; 0];

        mgauss(:,:,i)=twodgauss(x0,xdata);
        rgauss(:,:,i)=twodgauss(x1,xdata);
        Toponm=Toponm.*mgauss(:,:,i);
        if i==1 
            Toponmmm=Toponmm.*mgauss(:,:,i);
            Toponrrr=Toponmm.*rgauss(:,:,i);
        else
            Toponmmm=Toponmmm+Toponmm.*mgauss(:,:,i);
            Toponrrr=Toponrrr+Toponmm.*rgauss(:,:,i);
        end
    %     imagesc(mgauss(:,:,i))
    %     pause(1)
    %     close all
    end

    % figure, imagesc(mgauss(:,:,5));
    % figure, imagesc(rgauss(:,:,5));
    % 
    figure, imagesc(Toponmmm), colormap(gray)
    figure, imagesc(Toponrrr), colormap(gray)
    % 
    a=sum(mgauss,3);
    figure, imagesc(a)
    
    r=sum(rgauss,3);
    figure, imagesc(r)
    % 
    % figure;
    % imagesc(Topon)
    % colormap(gray);
    % 
    % figure;
    % imagesc(Toponm)
    % colormap(gray)

    % corr_data1 = normxcorr2d(Topon,Topon);
    % % 
    % % corr_data2 = normxcorr2d(Toponm,Toponm);
    % % 
    % % corr_data3 = normxcorr2d(Topon,Toponm);
    % % 
%     corr_data4 = normxcorr2d(Topon,abs(Toponmmm));
% 
%     map=corr_data4;
%     [nx ny nz] = size(corr_data4);
%     N = 20;
%     theta = linspace(2*pi*(0-360/2)/360,2*pi*(0+360/2)/360,100);
%     % R = 1:N;
%     R = 0:N;
%     % O = zeros(N,nz);
%     O4 = zeros(N+1,nz);
% 
%     for i=1:nz
%         for j=1:length(R)
%             summe = 0;
%             count = 0;
%             for k=1:length(theta)
%                 x = round(nx/2)+round(R(j)*cos(theta(k)));
%                 y = round(ny/2)-round(R(j)*sin(theta(k)));
%                 if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
%                   summe=summe+map(y,x,i);
%                   count = count + 1;
%                 end
%             end
%             O4(j,i)=summe/count;
%         end
%     end
% 
%     corr_data5 = normxcorr2d(Topon,abs(Toponrrr));
% 
%     map=corr_data5;
%     [nx ny nz] = size(corr_data5);
%     N = 20;
%     theta = linspace(2*pi*(0-360/2)/360,2*pi*(0+360/2)/360,100);
%     % R = 1:N;
%     R = 0:N;
%     % O = zeros(N,nz);
%     O5 = zeros(N+1,nz);
% 
%     for i=1:nz
%         for j=1:length(R)
%             summe = 0;
%             count = 0;
%             for k=1:length(theta)
%                 x = round(nx/2)+round(R(j)*cos(theta(k)));
%                 y = round(ny/2)-round(R(j)*sin(theta(k)));
%                 if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
%                   summe=summe+map(y,x,i);
%                   count = count + 1;
%                 end
%             end
%             O5(j,i)=summe/count;
%         end
%     end
    
    corr_data6 = normxcorr2d(Topon,sum(mgauss(:,:,:),3));
    figure(100), imagesc(corr_data6), colormap(gray)
    map=corr_data6;
    [nx ny nz] = size(corr_data6);
    N = 20;
    theta = linspace(2*pi*(0-360/2)/360,2*pi*(0+360/2)/360,100);
    % R = 1:N;
    R = 0:N;
    % O = zeros(N,nz);
    O6 = zeros(N+1,nz);

    for i=1:nz
        for j=1:length(R)
            summe = 0;
            count = 0;
            for k=1:length(theta)
                x = round(nx/2)+round(R(j)*cos(theta(k)));
                y = round(ny/2)-round(R(j)*sin(theta(k)));
                if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
                  summe=summe+map(y,x,i);
                  count = count + 1;
                end
            end
            O6(j,i)=summe/count;
        end
    end
    
    corr_data7 = normxcorr2d(Topon,sum(rgauss(:,:,:),3));

    map=corr_data7;
    [nx ny nz] = size(corr_data7);
    N = 20;
    theta = linspace(2*pi*(0-360/2)/360,2*pi*(0+360/2)/360,100);
    % R = 1:N;
    R = 0:N;
    % O = zeros(N,nz);
    O7 = zeros(N+1,nz);

    for i=1:nz
        for j=1:length(R)
            summe = 0;
            count = 0;
            for k=1:length(theta)
                x = round(nx/2)+round(R(j)*cos(theta(k)));
                y = round(ny/2)-round(R(j)*sin(theta(k)));
                if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
                  summe=summe+map(y,x,i);
                  count = count + 1;
                end
            end
            O7(j,i)=summe/count;
        end
    end
    
    
%     close all;
    if z==1
%         O4ave=O4;
%         O5ave=O5;
        O6ave=O6;
        O7ave=O7;
    else
%         O4ave=O4ave+O4;
%         O5ave=O5ave+O5;
        O6ave=O6ave+O6;
        O7ave=O7ave+O7;
    end
% end
%      figure, plot((0:1:N),(O4ave)/100,'.k',(0:1:N),(O5ave)/100,'.r','linewidth',2)
     figure, plot((0:1:N),(O6ave)/100,'.k',(0:1:N),(O7ave)/100,'.r','linewidth',2)
    % img_plot3(corr_data4-corr_data1);
