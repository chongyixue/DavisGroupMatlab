function newperim = testet(hrestopo, inptopo, hresc, inpc, fperimeter)

piezo1 = hrestopo.r(2)-hrestopo.r(1);
piezo2 = inptopo.r(2)-inptopo.r(1);

% hresc = hresc / piezo1;
% 
% inpc = inpc / piezo2;

newperim = fperimeter;

for i=1:length(fperimeter)

    dum1 = fperimeter{i} * piezo2;
    
    for k=1:length(dum1(:,2))
        
        xxx = dum1(k,2);
        yyy = dum1(k,1);
        
        dum2 = ((inpc(:,1)-xxx).^2 + (inpc(:,2) - yyy).^2).^0.5;
        [dum3, dumind] = min(dum2);
        
        xxx2 = ((xxx-inpc(dumind,1)) + hresc(dumind,1)) /piezo1;
        yyy2 = ((yyy-inpc(dumind,2)) + hresc(dumind,2)) /piezo1;
        
        dum4(k,2) = xxx2;
        dum4(k,1) = yyy2;
        
    end
    
    newperim{i} = dum4;
    clear dum1 dum2 dum3 dum4
end



% figure, img_plot5(topo1.map);
% hold on
% line([xxx-1, xxx+1],[yyy-1,yyy+1],'LineStyle','-','Color','b','LineWidth',2);
% hold off
% 
% figure, img_plot5(topo2.map);
% hold on
% line([xxx2-1*piezo1/piezo2,xxx2+1*piezo1/piezo2],[yyy2-1*piezo1/piezo2,yyy2+1*piezo1/piezo2],'LineStyle','-','Color','b','LineWidth',2);
% hold off


end