
dc = [];
ahl = [];
cc = 1;

% for i=11:31
%     T = readtable(['C:\Users\pspra\Desktop\2017\1701',num2str(i),'.txt']);
%     test = T.Var5;
%     ll = length(test);
%     ahl(cc) = (mean( test(ll-500:ll) ) - mean( test(1:501) ) ) / 24;
%     dc(cc) = cc;
%     cc = cc+1;
%     clear T;
% end

for i=5:9
    T = readtable(['C:\Users\pspra\Desktop\2017\17020',num2str(i),'.txt']);
    test = T.Var5;
    ll = length(test);
    ahl(cc) = (mean( test(ll-500:ll) ) - mean( test(1:501) ) ) / 24;
    dc(cc) = cc;
    cc = cc+1;
    clear T;
end

for i=10:28
    T = readtable(['C:\Users\pspra\Desktop\2017\1702',num2str(i),'.txt']);
    test = T.Var5;
    ll = length(test);
    if i==19
        figure, plot(test)
    end
    ahl(cc) = (mean( test(ll-500:ll) ) - mean( test(1:501) ) ) / 24;
    dc(cc) = cc;
    cc = cc+1;
    clear T;
end

for i=1:9
    T = readtable(['C:\Users\pspra\Desktop\2017\17030',num2str(i),'.txt']);
    test = T.Var5;
    ll = length(test);
    ahl(cc) = (mean( test(ll-500:ll) ) - mean( test(1:501) ) ) / 24;
    dc(cc) = cc;
    cc = cc+1;
    clear T;
end

for i=10:24
    T = readtable(['C:\Users\pspra\Desktop\2017\1703',num2str(i),'.txt']);
    test = T.Var5;
    ll = length(test);
    ahl(cc) = (mean( test(ll-500:ll) ) - mean( test(1:501) ) ) / 24;
    dc(cc) = cc;
    cc = cc+1;
    clear T;
end

figure, plot(dc(:), ahl(:),'k.-', 'LineWidth', 2)
hold on
line([16, 16], [-0.2, 0.5], 'Color', 'r','LineStyle','--', 'LineWidth', 2)

% line([20, 20], [-0.2, 0.5], 'Color', 'b','LineStyle','--', 'LineWidth', 2)
% 
% line([22, 22], [-0.2, 0.5], 'Color', 'b','LineStyle','--', 'LineWidth', 2)

line([23, 23], [-0.2, 0.5], 'Color', 'm','LineStyle','--', 'LineWidth', 2)

% line([25, 25], [-0.2, 0.5], 'Color', 'b','LineStyle','--', 'LineWidth', 2)
% 
% line([26, 26], [-0.2, 0.5], 'Color', 'b','LineStyle','--', 'LineWidth', 2)

line([27, 27], [-0.2, 0.5], 'Color', 'm','LineStyle','--', 'LineWidth', 2)

% line([28, 28], [-0.2, 0.5], 'Color', 'b','LineStyle','--', 'LineWidth', 2)
% 
% line([30, 30], [-0.2, 0.5], 'Color', 'b','LineStyle','--', 'LineWidth', 2)

line([32, 32], [-0.2, 0.5], 'Color', 'c','LineStyle','--', 'LineWidth', 2)

hold off




