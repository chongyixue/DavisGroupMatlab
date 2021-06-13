% 2020-12-23 YXC

% start R, G, B,endR,G,B,time,right/wrong

result = ColorGameResult;

filter = (result(:,end)==1).*(result(:,end-1)<10);
thresholdt = mean(result(:,end-1).*filter);
thresholdt = thresholdt*0.8;

% thresholdt = 1;
ms=10;

figure,
for i=1:size(result,1)
    A = result(i,1:3);
    B = result(i,4:6);
    if or(result(i,end)==0,result(i,end-1)>thresholdt)
        plot3([A(1),B(1)],[A(2),B(2)],[A(3),B(3)],'Color',0.5*(A+B));
        hold on
%     else
%         if sum((A+B)/2)<1
%             plot3((A(1)+B(1))/2,(A(2)+B(2))/2,(A(3)+B(3))/2,'Marker','o','Color','w','MarkerSize',ms);hold on
%         else
%             plot3((A(1)+B(1))/2,(A(2)+B(2))/2,(A(3)+B(3))/2,'Marker','o','Color','k','MarkerSize',ms);hold on
%         end
    end
    
    plot3([A(1)],[A(2)],[A(3)],'Color',A,'Marker','.','MarkerSize',ms);hold on
    plot3(B(1),B(2),B(3),'Color',B,'Marker','.','MarkerSize',ms);hold on
    
    
end




