% lets make figure 1
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%

%this is panel A
figure(1),
%subaxis(3,2,1, 'Spacing', sp, 'Padding', 0, 'Margin', 0),
h = [1 2 3 4];
X = repmat(h,1,4);
Y =repmat(h,4,1);
Y = Y(:)';
s = 2.5/2;
iron_mark=s*40;
Xs = [1.5 2.5 3.5 1.5 3.5];
Ys = [1.5 2.5 1.5 3.5 3.5];
Xs2 = [1.5 2.5 3.5 2.5];
Ys2 = [2.5 1.5 2.5 3.5];
Se_mark = s*70;
Se_mark2 = s*50;
plot(X,Y,'.','MarkerSize',iron_mark,'Color',[0.2 0.2 1]);
hold on
plot(Xs,Ys,'.','MarkerSize',Se_mark2,'Color',[1 0.4 0]);
plot(Xs2,Ys2,'.','MarkerSize',Se_mark,'Color',[1 0.4 0]);
plot([Xs2 1.5 2.5],[Ys2 2.5 1.5],'-k','LineWidth',2);
plot([2 3 3 2 2],[2 2 3 3 2],'--k','LineWidth',2);
%plot(Xs2,Ys2,'or','MarkerSize',Se_mark2);
hold off
axis([1 4 1 4]);
axis square
axis off

figsiz=[25 25];
fig_siz(figsiz/2.5);
figw