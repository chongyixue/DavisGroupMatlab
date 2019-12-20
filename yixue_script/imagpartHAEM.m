


function imag = imagpartHAEM(cx,cy,qx,qy,px,topo,map,E_layer)
comment = 'random';
[prft_data] = singleimpurityshiftcenter(map, topo, [cx, cy], 50);
[realft_data, imagft_data] = singleimpurityIMGmap(prft_data);

imag = 0;
temp = qx;
qx = qy;
qy = temp;

%close all
counter = 0;
for i= qx - px:qx + px
    for j = qy - px: qy + px
        imag = imag + imagft_data.map(i,j,E_layer);
        counter = counter + 1;
    end
end
imag = imag/counter;

%disp(imag)
end

%% BACKUP
% function imag = imagpartHAEM(cx,cy,qx,qy,px,topo,map,E_layer)
% comment = 'random';
%  [prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis_noprint(map, topo, [cx, cy], 50);
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis_noprint(prft_data, [qx, qy], [qx, qy], px, 'ncircle',comment);
% imag = 0;
% temp = qx;
% qx = qy;
% qy = temp;
%
% %close all
% counter = 0;
% for i= qx - px:qx + px
%     for j = qy - px: qy + px
%         imag = imag + imagft_data.map(i,j,E_layer);
%         counter = counter + 1;
%     end
% end
% imag = imag/counter;
%
% %disp(imag)
% end