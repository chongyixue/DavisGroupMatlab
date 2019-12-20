% script to play with spectrum from map
% 2018/9/13
% MoTeSe project


% linespec = obj_80913a06_G_rescale;
% topo = obj_80913A06_T_rescale;
% linespec2 = linespec;
linespec = map;
topo = topo;
linespec2 = linespec;


topo.name = 'average_gap';

for xxx=1:100
    
    
    py =1;
    Nsmooth=10;
%     img_obj_viewer_yxc(linespec)
    
    for px = xxx:xxx
        y = running_average(linespec,px,py,0,0);
%         y(1:5)
        y_smooth = running_average(linespec,px,py,Nsmooth,0);
        
        averagegap = gapsize_smoothgap(linespec,px,py,Nsmooth);
        
        
        for py = 1:100
            topo.map(py,px,1)=averagegap;
            for E=1:201
                linespec.map(py,px,E) = y_smooth(E);
            end
        end
%         img_obj_viewer_yxc(linespec)
    end
    
    
end
img_obj_viewer_yxc(linespec)
img_obj_viewer_yxc(topo)

gapspectrum = topo.map(3,:,1);
figure()
plot(linspace(0,30,100),gapspectrum);
title('Gap size in mV');
xlabel('nm')
avg = mean(gapspectrum);
figure()
plot(linspace(1,100,100),abs(fft(gapspectrum-avg)));
hold on
plot([21 21],[0 0.12],'r')
plot([81 81],[0 0.12],'r')
title('FFT of gapline-red line indicates proposed Fermi-Arc Scattering');
xlabel('pixel');

