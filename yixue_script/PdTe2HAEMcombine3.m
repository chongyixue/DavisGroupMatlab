
%%this script plots multiple HAEM analysis
%6 Oct 2017
clear bigdata;
bigdata(1) = rho71005a03LF;
bigdata(2) = rho71006a00;
bigdata(3) = rho71006a01;
bigdata(4) = rho71001a01;
bigdata(5) = rho71002a00;
bigdata(6) = rho71006a02;
bigdata(7) = rho71006a02_crop60;

color = {[0,0,1],[0,0.8,0.2],[0,0.6,0.4],[0.2,0.2,0.6],[0.4,0.4,0.2],[0.8,0.1,0.1],[0.5,0.5,0]};


ndata = length(bigdata)-1;
energypoints = 10;
energies = bigdata(1).rho1.ev;

for i=1:ndata
    bigdata(i).rho(1)=bigdata(i).rho1;
    bigdata(i).rho(2)=bigdata(i).rho2;
    bigdata(i).rho(3)=bigdata(i).rho3;
    bigdata(i).rho(4)=bigdata(i).rho4;
    bigdata(i).rho(5)=bigdata(i).rho5;
    bigdata(i).rho(6)=bigdata(i).rho6;
    bigdata(i).rho(7)=bigdata(i).rho7;
    bigdata(i).rho(8)=bigdata(i).rho8;
    bigdata(i).rho(9)=bigdata(i).rho9;
end


%make rho(point,energylayer,arp)
clear list;
for p=1:9
    for m = 1:energypoints
        for n = 1:ndata
            list = bigdata(n).rho(p).arp1(m);
            antireal(p,m,n)=list;
            list = bigdata(n).rho(p).aip1(m);
            antiimag(p,m,n)=list;
            list = bigdata(n).rho(p).srp1(m);
            symreal(p,m,n)=list;
            list = bigdata(n).rho(p).sip1(m);
            symimag(p,m,n)=list;
        end
    end
end


data = {'antireal','antiimag','symreal','symimag'};
po = {'q_130^o','q_190^o','q_1150^o','q_330^o','q_260^o','q_390^o','q_2120^o','q_3150^o','q_2180^o'};

for k=1:4
    %change point, datatype
    dataname = data{k};
    clear eval;
    datatype = eval(dataname);
    
    
    
    for p = 1:9
        point = string(p);
        
        figure,
        for h=1:ndata
            plot(energies, datatype(p,:,h),'-o','color',color{h}, 'LineWidth', 2, 'MarkerSize', 10);
            hold on;
        end
        
        ymin = min(0,min(min(min(datatype(p,:,:))))-0.1*abs(min(min(min(datatype(p,:,:))))));
        ymax = max(max(max(max(datatype(p,:,:))))+0.1*abs(max(max(max(datatype(p,:,:))))),0);
        
        %vertical and horizontal lines (coherence peak and zero)
        plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
        plot([0.32,0.32],[ymin,ymax],'color','r', 'LineWidth', 2);
        % title(strcat({'Anti-sym. Re\{FT[I(q)]\}'},{' point '},num2str(point)));
        title(strcat({dataname},{' point '},po{p}));
        
        xlim([energies(end), energies(1)])
        ylim([ymin,ymax])
        xlabel('E [meV]');
        ylabel('q-integrated intensity');
        ax2 = gca;
        ax2.FontSize = 20;
        ax2.TickLength = [0.02 0.02];
        ax2.LineWidth = 2;
        box on
        
        savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
        comment = strcat({'HAEMpoint'},{num2str(p)},dataname,date);
        slstr = strcat(savepath,comment,'.','png');
        set(gcf, 'PaperPositionMode', 'auto');
        saveas(gcf, slstr{1}, 'png');
        
        hold off
        
    end
end