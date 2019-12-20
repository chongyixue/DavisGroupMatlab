function [dcut, pcut] = qpi_radial_linecuts(data, rp)


% map = data.map(:,:, data.e*1000 == ev);
[nx, ny, nz] = size(data.map);

xc = round(nx/2)+1;
yc = round(ny/2)+1;



ev_list = [-25, -23.75, -22.5, -21.25, -20, -18.75, -17.5, -16.25, -15,...
           15, 16.25, 17.5, 18.75, 20, 21.25, 22.5, 23.75, 25];
for m=1:length(ev_list)
    ev = ev_list(m);
    cc = 1;
    for k=0:5:90

        xe = round( xc + rp*cos(k*pi/180) ) ;
        ye = round( yc + rp*sin(k*pi/180) ) ;
        lcut = line_cut_v4(data,[xc, yc],[xe, ye],2);

        cut = lcut.cut(:,data.e*1000 == ev);
        ncut = cut - min(cut);
        ncut = ncut / mean( ncut );

        %%
        le = length(ncut);

        smooth_ncut = ncut;
        smooth_cut = cut;

        for i=2 : le-1
            smooth_ncut(i) = (ncut(i)+ncut(i-1)+ncut(i+1)) / 3;
            smooth_cut(i) = (cut(i)+cut(i-1)+cut(i+1)) / 3;
        end

        %%
        dcut{m, cc, 1} = lcut.r;
        %dcut{cc, 2} = cut;
        dcut{m, cc, 2} = smooth_cut;
        %dcut{cc, 3} = ncut;
        dcut{m, cc, 3} = smooth_ncut;

        pcut{m, cc, 1} = xe;
        pcut{m, cc, 2} = ye;

        cc = cc+1;
    %     
        figure, plot(lcut.cut(:,data.e*1000 == ev),...
            'k.-', 'LineWidth', 2, 'MarkerSize',15)

    end
    cc = cc-1;
    close all
    %% plot the line-cuts all on top of one qpi layer
    img_plot2(data.map(:,:, data.e*1000 == ev));
    hold on
    plot([xc pcut{m,1,1}],[yc pcut{m,1,2}],'g');  
    for k=2:cc
        plot([xc pcut{m,k,1}],[yc pcut{m,k,2}],'g');
    end
    hold off  
    
end

% figure, plot(dcut{1,1}, dcut{1, 3}, 'k.-', 'LineWidth', 2, 'MarkerSize',15)
% hold on
% for k=2:cc
%     
%     plot(dcut{k,1}, dcut{k, 3} + (k-1)*1, 'k.-', 'LineWidth', 2, 'MarkerSize',15)
%     
% end
% 
% hold off
% 
% figure, plot(dcut{1, 3}, 'k.-', 'LineWidth', 2, 'MarkerSize',15)
% hold on
% for k=2:cc
%     
%     plot(dcut{k, 3} + (k-1)*1, 'k.-', 'LineWidth', 2, 'MarkerSize',15)
%     
% end
% 
% hold off

% %% plot the line-cuts all on top of one qpi layer
% img_plot2(data.map(:,:, data.e*1000 == ev));
% hold on
% plot([xc pcut{1,1}],[yc pcut{1,2}],'g');  
% for k=2:cc
%     plot([xc pcut{k,1}],[yc pcut{k,2}],'g');
% end
% hold off   



end