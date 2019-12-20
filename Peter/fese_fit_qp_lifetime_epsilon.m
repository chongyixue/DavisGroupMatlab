function fese_fit_qp_lifetime_epsilon(obj_605047A00_8cr)
%% epsilon pocket

epsilonmap = obj_605047A00_8cr;

% pixel values of the q2 vector of epsilon pocket from -1.1 and then -0.9 to -0.5 meV
xm_peter = [232, 237, 239, 243, 246, 247];
ym_peter = [189, 189, 190, 191, 192, 193];

%radius in pixel for line-cut
r = 30;
qc = zeros(2*r, 6);

for i=1:length(xm_peter)

    lcuth = line_cut_v4(epsilonmap,[xm_peter(i)-r, ym_peter(i)],[xm_peter(i)+r, ym_peter(i)],0);
    img_plot2(epsilonmap.map(:,:,i));
    hold on;  
    plot([xm_peter(i)-r xm_peter(i)+r],[ym_peter(i) ym_peter(i)],'g');
    hold off
    figure, plot(lcuth.r, lcuth.cut(:, i))
    
%     lcutv = line_cut_v4(epsilonmap,[xm_peter(i), ym_peter(i)-r],[xm_peter(i), ym_peter(i)+r],0);
%     figure, plot(lcutv.r, lcutv.cut(:, i))
%     img_plot2(epsilonmap.map(:,:,i));
%     hold on;  
%     plot([xm_peter(i) xm_peter(i)],[ym_peter(i)-r ym_peter(i)+r],'g');
%     hold off
    
    test = 1;
    
    ec(:, i) = lcuth.cut(:, i);
    nc(:, i) = ec(:, i) / max(ec(:,i));
    qc(:,i) = lcuth.r;
%     close all;
end
close all

figure, 
plot(qc(:,1), ec(:,1), qc(:,2), ec(:,2), qc(:,3), ec(:,3), qc(:,4), ec(:,4), qc(:,5), ec(:,5), qc(:,6), ec(:,6))

figure, hold on
for i=1:length(xm_peter)
    plot(qc(:,i), nc(:,i)+(i-1)*0.45,  'k.-', 'LineWidth', 2, 'MarkerSize', 15)
end
hold off

end
%% comment
% for alpha pocket the vertical line-cuts are pretty useless because of the
% big blob -> use horizontal line cuts
% similarly, for the epsilon  pocket vertical line-cuts avoid the broad
% background from the scattering along the horizontal contour of the pocket