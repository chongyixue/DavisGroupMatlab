
%%
%everything starting from "bigdata" strucure

%define bigdataholder so that the original copy remains intact.

clear list;

noise.rho(1)=noise.rho1;
noise.rho(2)=noise.rho2;
noise.rho(3)=noise.rho3;
noise.rho(4)=noise.rho4;
noise.rho(5)=noise.rho5;
noise.rho(6)=noise.rho6;
noise.rho(7)=noise.rho7;

energies = rho1.ev;
energypoints = 10;

for p=1:1
    for m = 1:energypoints
        for n = 1:7
            list = noise.rho(n).arp1(m);
            antireal(p,m,n)=list;
            list = noise.rho(n).aip1(m);
            antiimag(p,m,n)=list;
            list = noise.rho(n).srp1(m);
            symreal(p,m,n)=list;
            list = noise.rho(n).sip1(m);
            symimag(p,m,n)=list;
        end
    end
end


data = {'antireal','antiimag','symreal','symimag'};

%%
%initialize a datamatrix where by it is a structure with the 4 matrices
% (+energy array)
%antireal,antiimag,symreal and symimag
%within each is a matrix of dimension(rows,column)
%rows = dataset
%column = energy points
ndata = 1;
clear datamatrix;
rows = 7;%Don't want to take last dataset
datamatrix.antireal(1:rows,1:10,1:1)=0;%index 3 is number of points
datamatrix.antiimag(1:rows,1:10,1:1)=0;%index 3 is number of points
datamatrix.symreal(1:rows,1:10,1:1)=0;%index 3 is number of points
datamatrix.symimag(1:rows,1:10,1:1)=0;%index 3 is number of points
datamatrix.energies = energies;

%%
%now rearange fill in the datamatrix

for k=1:4
    %change point, datatype
    dataname = data{k};
    clear eval;
    datatype = eval(dataname);
    
    
    
    for p = 1:1
        point = string(p);
        
        
        figure,
        for h=1:rows
            plot(energies, datatype(p,:,h),'-o','color',color{h}, 'LineWidth', 2, 'MarkerSize', 10);
            hold on;
            holder = datatype(p,:,h);
            if k==1
                datamatrix.antireal(h,:,p) = holder;
            else if k ==2
                    datamatrix.antiimag(h,:,p) = holder;
                else if k == 3
                        datamatrix.symreal(h,:,p)=holder;
                    else
                        datamatrix.symimag(h,:,p)=holder;
                    end
                end
            end
        end
        
        ymin = min(0,min(min(min(datatype(p,:,:))))-0.1*abs(min(min(min(datatype(p,:,:))))));
        ymax = max(max(max(max(datatype(p,:,:))))+0.1*abs(max(max(max(datatype(p,:,:))))),0);
        
        %vertical and horizontal lines (coherence peak and zero)
        plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
        plot([0.32,0.32],[ymin,ymax],'color','r', 'LineWidth', 2);
        % title(strcat({'Anti-sym. Re\{FT[I(q)]\}'},{' point '},num2str(point)));
        title(strcat({dataname},{' point '},point));
        
        xlim([energies(end), energies(1)])
        ylim([ymin,ymax])
        xlabel('E [meV]');
        ylabel('q-integrated intensity');
        ax2 = gca;
        ax2.FontSize = 20;
        ax2.TickLength = [0.02 0.02];
        ax2.LineWidth = 2;
        box on
        
        %         savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
        %         comment = strcat({'HAEMpoint'},{num2str(p)},dataname);
        %         slstr = strcat(savepath,comment,'.','png');
        %         set(gcf, 'PaperPositionMode', 'auto');
        %         saveas(gcf, slstr{1}, 'png');
        
        hold off
    end
end

%%
% now one can define the mean and errors etc
% the mean/sd is now (point,average)
% the "1"s are matrix dimension direction
% the 0 in std is for normalization
datamatrix.mean.antireal = mean(datamatrix.antireal,1);
datamatrix.mean.antiimag = mean(datamatrix.antiimag,1);
datamatrix.mean.symreal = mean(datamatrix.symreal,1);
datamatrix.mean.symimag = mean(datamatrix.symimag,1);

datamatrix.std.antireal = std(datamatrix.antireal,0,1);
datamatrix.std.antiimag = std(datamatrix.antiimag,0,1);
datamatrix.std.symreal = std(datamatrix.symreal,0,1);
datamatrix.std.symimag = std(datamatrix.symimag,0,1);


p=1;
    
%% antireal
datatype=antireal;
figure, errorbar(energies,datamatrix.mean.antireal,datamatrix.std.antireal,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 10);
hold on
maxerror = max(max(datamatrix.std.antireal));
ymin = min(0,min(min(min(datatype(p,:,:))))-0.1*abs(min(min(min(datatype(p,:,:))))));
ymax = max(max(max(max(datatype(p,:,:))))+0.1*abs(max(max(max(datatype(p,:,:))))),0);

%vertical and horizontal lines (coherence peak and zero)
%plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
plot([0,0.9],[0,0],'--','color','r', 'LineWidth', 2);
plot([0.325,0.325],[ymin,ymax],'color','r', 'LineWidth', 2);
title(strcat('antireal',{'random point '}));

xlim([0, 0.9])
%xlim([energies(end), energies(1)])
ylim([ymin,ymax])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
comment = strcat({'combinedHAEMpoint'},'random','antireal');
slstr = strcat(savepath,comment,'.','png');
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, slstr{1}, 'png');

hold off

%% antiimag
datatype=antiimag;
figure, errorbar(energies,datamatrix.mean.antiimag,datamatrix.std.antiimag,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 10);
hold on
maxerror = max(max(datamatrix.std.antiimag));
ymin = min(0,min(min(min(datatype(p,:,:))))-0.1*abs(min(min(min(datatype(p,:,:))))));
ymax = max(max(max(max(datatype(p,:,:))))+0.1*abs(max(max(max(datatype(p,:,:))))),0);

%vertical and horizontal lines (coherence peak and zero)
%plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
plot([0,0.9],[0,0],'--','color','r', 'LineWidth', 2);
plot([0.325,0.325],[ymin,ymax],'color','r', 'LineWidth', 2);
title(strcat('antiimag',{'random point '}));

xlim([0, 0.9])
%xlim([energies(end), energies(1)])
ylim([ymin,ymax])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
comment = strcat({'combinedHAEMpoint'},'random','antiimag');
slstr = strcat(savepath,comment,'.','png');
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, slstr{1}, 'png');

hold off


%% symreal
datatype=symreal;
figure, errorbar(energies,datamatrix.mean.symreal,datamatrix.std.symreal,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 10);
hold on
maxerror = max(max(datamatrix.std.symreal));
ymin = min(0,min(min(min(datatype(p,:,:))))-0.1*abs(min(min(min(datatype(p,:,:))))));
ymax = max(max(max(max(datatype(p,:,:))))+0.1*abs(max(max(max(datatype(p,:,:))))),0);

%vertical and horizontal lines (coherence peak and zero)
%plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
plot([0,0.9],[0,0],'--','color','r', 'LineWidth', 2);
plot([0.325,0.325],[ymin,ymax],'color','r', 'LineWidth', 2);
title(strcat('symreal',{'random point '}));

xlim([0, 0.9])
%xlim([energies(end), energies(1)])
ylim([ymin,ymax])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
comment = strcat({'combinedHAEMpoint'},'random','symreal');
slstr = strcat(savepath,comment,'.','png');
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, slstr{1}, 'png');

hold off

%% symimag
datatype=symimag;
figure, errorbar(energies,datamatrix.mean.symimag,datamatrix.std.symimag,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 10);
hold on
maxerror = max(max(datamatrix.std.symimag));
ymin = min(0,min(min(min(datatype(p,:,:))))-0.1*abs(min(min(min(datatype(p,:,:))))));
ymax = max(max(max(max(datatype(p,:,:))))+0.1*abs(max(max(max(datatype(p,:,:))))),0);

%vertical and horizontal lines (coherence peak and zero)
%plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
plot([0,0.9],[0,0],'--','color','r', 'LineWidth', 2);
plot([0.325,0.325],[ymin,ymax],'color','r', 'LineWidth', 2);
title(strcat('symimag',{'random point '}));

xlim([0, 0.9])
%xlim([energies(end), energies(1)])
ylim([ymin,ymax])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
comment = strcat({'combinedHAEMpoint'},'random','symimag');
slstr = strcat(savepath,comment,'.','png');
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, slstr{1}, 'png');

hold off

