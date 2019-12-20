function [tformall, tformcell] = fetese_alignment_multilayer(topo1c,topo2c,nl)


[nx, ny, ne] = size(topo1c);

[tformall, fixed, moving] = fetese_alignment(topo1c, topo2c);

tformcell = {};
% for i=0:nl-1
%     topo1c2 = topo1c(round(i*nx/nl)+1:round((i+1)*nx/nl),1:end,1);
%     topo2c2 = topo2c(round(i*nx/nl)+1:round((i+1)*nx/nl),1:end,1);
%     
%     [tform, fixedtopo, topo2al] = fetese_alignment(topo1c2,topo2c2);
%         
%     tformcell{i+1} = tform;
%     
% %     topo2al = imwarp(topo2c2,tform,'OutputView',imref2d(size(topo1c2)),'Interp','Cubic');
%     
%     if i==0
%         topo2cw = topo2al;
%         fixed2w = fixedtopo;
%     else
%         topo2cw = cat(1,topo2cw,topo2al);
%         fixed2w = cat(1,fixed2w,fixedtopo);
%     end
% end


figure, img_plot4(abs(fixed-moving));
sum(sum(abs(fixed-moving)))/(size(fixed,1)*size(fixed,2))
figure, img_plot4(wiener2(abs(fixed-moving),[3,3]));
% figure, img_plot4(abs(fixed2w-topo2cw));
% figure, img_plot4(abs(fixed-moving)- abs(fixed-topo2cw));

end