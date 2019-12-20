function unit_cell_avg(img,phase)
%[nr nc] = size(crop_region);
%avg_img = zeros(nr,nc);
%avg_img = zeros(15,15);

tol = 0.3;
for i = 30:40
    %i
    for j = 30:40
       % j
        A = ((phase.phi1 > phase.phi1(i,j)- tol) & (phase.phi1 < phase.phi1(i,j) + tol)...
        & (phase.phi2 > phase.phi2(i,j)- tol) & (phase.phi2 < phase.phi2(i,j) + tol));
         mean(mean(img(A)));
        avg_img(i-29,j-29) = mean(mean(img(A)));
    end
end
img_plot2(avg_img);
img_plot2(img(30:40,30:40));
end