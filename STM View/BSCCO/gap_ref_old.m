function new_data = gap_ref(data,gapmap)
n = 30;
[nr nc nz] = size(data.map);
new_data = data;

e = data.e*1000;
min_gap = max(max(gapmap(gapmap < 0)));
min_e_index = find_zero_crossing(e - min_gap);
max_end_index = length(e) - find_zero_crossing(- e - e + min_gap);

st_pt = 0;
end_pt = e(end) - min_gap;
e_int = abs(end_pt/n);
new_e = linspace(st_pt,end_pt,n);
new_data.map = zeros(nr,nc,n);
new_data.e = new_e;
%nr = 1; nc = 1;
for i = 1:nr
    i
    for j = 1:nc   
        ref_e = e - gapmap(i,j);
        st_index = find_zero_crossing(ref_e);
        end_index = length(e) - find_zero_crossing(- e - e + gapmap(i,j));
        end_index = min(nz, st_index+n);
        Y = squeeze(squeeze(data.map(i,j,st_index:end_index)));
        x = ref_e(st_index:end_index);
        %figure; plot(ref_e,squeeze(squeeze(data.map(i,j,:)))); hold on; plot(x,Y,'r')
        if length(x) > 2
        yi = interp1(x,Y,new_e);
        end
        %figure; plot(new_e,yi,'o'); hold on; plot(x,Y,'rx');
        new_data.map(i,j,:) = yi;
    end
end
new_data.e = new_data.e/1000;
end