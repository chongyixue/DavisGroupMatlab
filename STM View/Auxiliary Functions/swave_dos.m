function y = swave_dos(x,gap_size)
y = ones(length(x),1);
ind2 = find_zero_crossing(x - gap_size);
ind1 = find_zero_crossing(x + gap_size);

y(ind1) = 2; y(ind2) = 2;
y(ind1+1:ind2-1) = 0;
figure; 
plot(x,y);
ylim([0 2]);

end
