function find_phase_slip(phase,tol)
load_color;
% count_r = 58;
% count_c = 36;
% [nr nc] = size(img);
% %while(1)
%     px1 = img(count_r,count_c);
%     nbhd_px1 = img(max(1,count_r-1):min(nr,count_r+1),max(1,count_c-1):min(nc,count_c+1));
%     A = (abs(nbhd_px1 - px1) >= 2*pi-tol);
%     %break;
% %end
% 
% img_plot2(nbhd_px1,Cmap.Defect1,'Phase slip test');

[FX1 FY1] = gradient(phase.theta1);
[FX2 FY2] = gradient(phase.theta2);
% 
 [r c] = find(abs(FX1) > 2 | abs(FY1) > 2);
 img_plot2(phase.theta1);
 hold on; plot(c,r,'mx');

%A = (phase.theta2 <= 0);
%img_plot2(phase.theta2 + A*2*pi,Cmap.Defect1);

end