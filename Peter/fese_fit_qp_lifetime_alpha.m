function fese_fit_qp_lifetime_alpha(data)


%% alpha pocket
alphamap = data;


% pixel values of the q2 vector of alpha pocket from -2.1 to -0.8 meV
xg_peter = [84, 82, 81, 81, 81, 80, 81, 80, 79, 78, 77, 76, 75, 75];
yg_peter = [52, 48, 47, 46, 45, 44, 42, 40, 40, 39, 39, 38, 38, 37];

% radius for line-cut in pxl
r = 15;
qc = zeros(2*r, 6);

for i=1:length(xg_peter)

    lcuth = line_cut_v4(alphamap,[xg_peter(i)-r, yg_peter(i)],[xg_peter(i)+r, yg_peter(i)],0);
    img_plot2(alphamap.map(:,:,i+3));
    hold on;  
    plot([xg_peter(i)-r xg_peter(i)+r],[yg_peter(i) yg_peter(i)],'g');
    hold off
    figure, plot(lcuth.r, lcuth.cut(:, i+3))
    
%     lcutv = line_cut_v4(alphamap,[xg_peter(i), yg_peter(i)-r],[xg_peter(i), yg_peter(i)+r],0);
%     figure, plot(lcutv.r, lcutv.cut(:, i+3))
%     img_plot2(alphamap.map(:,:,i+3));
%     hold on;  
%     plot([xg_peter(i) xg_peter(i)],[yg_peter(i)-r yg_peter(i)+r],'g');
%     hold off
    
    test = 1;
    ec(:, i) = lcuth.cut(:, i);
    nc(:, i) = ec(:, i) / max(ec(:,i));
    qc(:,i) = lcuth.r;
    close all;
end

figure, 
plot(qc(:,1), ec(:,1), qc(:,2), ec(:,2), qc(:,3), ec(:,3), qc(:,4), ec(:,4), qc(:,5), ec(:,5), qc(:,6), ec(:,6))

figure, hold on
for i=1:length(xg_peter)
    plot(qc(:,i), nc(:,i)+(i-1)*0.45, 'k.-', 'LineWidth', 2, 'MarkerSize', 15)
end
hold off

end
%% comment
% for alpha pocket the vertical line-cuts are pretty useless because of the
% big blob -> use horizontal line cuts
% similarly, for the epsilon  pocket vertical line-cuts avoid the broad
% background from the scattering along the horizontal contour of the pocket