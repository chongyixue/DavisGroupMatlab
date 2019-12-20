function disp_linecut(q,cut)
[nr nc] = size(cut);
figure;
lb = 5; hb = 70;
for i= 21:nc
    plot(q(lb:hb),cut(lb:hb,i) + i*70,'Linewidth',1.5);
    xlabel('q','fontsize',14,'fontweight','b');
    ylabel('|FT|','fontsize',14,'fontweight','b');
    xlim([min(q(lb:hb)) max(q(lb:hb))])
    hold on;
end