ev = imag_prft_data_crop.e * 1000;

imag_fex = squeeze ( sum ( sum ( imag_prft_data_crop.map(36:40, 36:40,:) ) ) / 25 );
imag_fey = squeeze ( sum ( sum ( imag_prft_data_crop.map(36:40, 62:66,:) ) ) / 25 );

real_fex = squeeze ( sum ( sum ( real_prft_data_crop.map(36:40, 36:40,:) ) ) / 25 );
real_fey = squeeze ( sum ( sum ( real_prft_data_crop.map(36:40, 62:66,:) ) ) / 25 );

ampl_fex = squeeze ( sum ( sum ( ampl_prft_data_crop.map(36:40, 36:40,:) ) ) / 25 );
ampl_fey = squeeze ( sum ( sum ( ampl_prft_data_crop.map(36:40, 62:66,:) ) ) / 25 );



figure, plot(ev,imag_fex,'Marker', 'o',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold on
plot(ev,imag_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);  
hold off



figure, plot(ev,real_fex,'Marker', 'o',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold on
plot(ev,real_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);  
hold off


figure, plot(ev,ampl_fex,'Marker', 'o',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold on
plot(ev,ampl_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);  
hold off