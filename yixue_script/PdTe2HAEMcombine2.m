
%%this script plots multiple HAEM analysis
%6 Oct 2017

bigdata(1) = rho71005a03LF;
bigdata(2) = rho71006a00;
bigdata(3) = rho71006a01;
bigdata(4) = rho71001a01;
bigdata(5) = rho71002a00;
bigdata(6) = rho71006a02;

color = {[0,0,1],[0,0.8,0.2],[0,0.6,0.4],[0.2,0.2,0.6],[0.4,0.4,0.2],[0.8,0.1,0.1]};



ndata = length(bigdata);
energypoints = 10;
energies = bigdata(1).rho1.ev;

%make antireal(energylayer,arp)
for m = 1:energypoints
    for n = 1:ndata
        list = bigdata(n).rho2.arp1(m);
        antireal(m,n)=list;
    end
end

for m = 1:energypoints
    for n = 1:ndata
        list = bigdata(n).rho2.aip1(m);
        antiimag(m,n)=list;
    end
end

for m = 1:energypoints
    for n = 1:ndata
        list = bigdata(n).rho2.srp1(m);
        symreal(m,n)=list;
    end
end

for m = 1:energypoints
    for n = 1:ndata
        list = bigdata(n).rho2.sip1(m);
        symimag(m,n)=list;
    end
end


%change point, datatype
point = '2';
dataname = 'antireal';
clear eval;
datatype = eval(dataname);





figure, 

for k=1:ndata
    plot(energies, datatype(:,k),'-o','color',color{k}, 'LineWidth', 2, 'MarkerSize', 10);
    hold on;
end



ymin = min(0,min(min(datatype))-0.1*abs(min(min(datatype))));
ymax = max(max(max(datatype))+0.1*abs(max(max(datatype))),0);

%vertical and horizontal lines (coherence peak and zero)
plot([energies(end),energies(1)],[0,0],'--','color','r', 'LineWidth', 2);
plot([0.32,0.32],[ymin,ymax],'color','r', 'LineWidth', 2);
% title(strcat({'Anti-sym. Re\{FT[I(q)]\}'},{' point '},num2str(point)));
 title(strcat({dataname},{' point '},num2str(point)));

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
comment = strcat({'HAEMpoint'},{num2str(1)},dataname);
slstr = strcat(savepath,comment,'.','png');
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, slstr, 'png');

hold off


