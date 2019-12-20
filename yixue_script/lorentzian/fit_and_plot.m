function [llshifted,index_assignment] = fit_and_plot(map,x,y,background,peakmV_array)

spec = squeeze(map.map(y,x,:))';
en = map.e;

maxx = max(spec);
minn = min(spec);

[peakenergy,~,~,~,~,~,~] = many_lorentzfit(en,spec,background,'plot');

[llshifted,index_assignment] = shift_peak_assignment_single_spec(peakenergy,peakmV_array);
len = length(llshifted);
for i = 1:len
    item = llshifted(i);
    if item ~= 0
        item = item/1000;
        plot([item,item],[minn,maxx],'k');
    end
end

end