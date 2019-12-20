%%
figure; 
n = 30;
cols = jet(n);
for i = 1:24
    plot(cut.r,cut.cut(:,i) -  i*400, 'color',cols(i,:)); hold on;
end