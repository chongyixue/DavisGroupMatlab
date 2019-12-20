function S = find_d2idv2(x,y, degree_poly,frac_peak,res)
S.x = x;
S.y = y;
S.dx = [];
S.dy = [];
S.inf_pt = 0;
S.gap_pk_pt = 0;
S.omega = 0;
S.degree_poly = degree_poly;
S.frac_peak = frac_peak;
S.res = res;

l_y = length(y);
peak_val = max(y);
peak_val_ind = find(y==peak_val);
S.gap_pk_pt = x(find(y == peak_val));
min_val = min(y(1:peak_val_ind));
min_val_ind = find(y==min_val,1,'last');
frac_val = (peak_val - min_val)*frac_peak + min_val;
% find set indices which satisfy being larger that frac_val and
% on the right side of the minimum
frac_peak_ind = find((y>=frac_val).*(x<=x(min_val_ind)) == 1,1); %change > to < for different sides
kstart = 1; kend = l_y - frac_peak_ind + 1 ;
v = x(kstart:end-kend); 
w = y(kstart:end-kend); %w = w'; 
[p P] = polyfit(v,w,degree_poly);
% generate fine spacing fit
spc = mean(abs(diff(v)));  

sgn = sign(S.gap_pk_pt);
v_refine = v(1):-sgn*spc/res:v(end);
f = polyval(p,v_refine,S);
% hold on; plot(v_refine,f,'r')
[df dv] = num_der2b(1,f,v_refine);
S.dx = dv;
S.dy = df;
[df2 dv2] = num_der2b(2,f,v_refine);
%figure; plot(dx2,df2)
inflect_index = find_zero_crossing(df2);
S.inf_pt = v_refine(inflect_index);
S.omega = abs(S.gap_pk_pt - S.inf_pt);
end