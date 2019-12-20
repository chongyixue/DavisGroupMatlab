%figure;
% tmp = 0;
% for i = 25:100
%     tmp = tmp + squeeze(G.map(i,193,1:end));
% end
% tmp = tmp/75;
% plot(G.e, tmp);
% tmp2 = 0
% for i = 25:100
%     tmp2 = tmp2 + squeeze(G.map(i,189,1:end));
% end
% tmp2 = tmp2/75;
% hold on
%plot(G.e, tmp2, 'r');

A = get_points2(T.topo2,1:256,20,bone);
m = colormap(cool(10));
figure;
for i=1:20
    tmp = squeeze(G.map(floor(A(1,i)),floor(A(2,i)),1:end));
    plot(G.e,tmp + 0.5*i)
    hold on
end
    
