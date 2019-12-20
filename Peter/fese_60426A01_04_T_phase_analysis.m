
imag_50mV_fex = sum ( sum ( obj_60426a01_crop_imag_prft.map(19:20, 19:20,:) ) ) / 4;
imag_50mV_fey = sum ( sum ( obj_60426a01_crop_imag_prft.map(19:20, 42:43,:) ) ) / 4;

real_50mV_fex = sum ( sum ( obj_60426a01_crop_real_prft.map(19:20, 19:20,:) ) ) / 4;
real_50mV_fey = sum ( sum ( obj_60426a01_crop_real_prft.map(19:20, 42:43,:) ) ) / 4;

imag_20mV_fex = sum ( sum ( obj_60426a02_crop_imag_prft.map(19:20, 19:20,:) ) ) / 4;
imag_20mV_fey = sum ( sum ( obj_60426a02_crop_imag_prft.map(19:20, 42:43,:) ) ) / 4;

real_20mV_fex = sum ( sum ( obj_60426a02_crop_real_prft.map(19:20, 19:20,:) ) ) / 4;
real_20mV_fey = sum ( sum ( obj_60426a02_crop_real_prft.map(19:20, 42:43,:) ) ) / 4;

imag_10mV_fex = sum ( sum ( obj_60426a03_crop_imag_prft.map(19:20, 19:20,:) ) ) / 4;
imag_10mV_fey = sum ( sum ( obj_60426a03_crop_imag_prft.map(19:20, 42:43,:) ) ) / 4;

real_10mV_fex = sum ( sum ( obj_60426a03_crop_real_prft.map(19:20, 19:20,:) ) ) / 4;
real_10mV_fey = sum ( sum ( obj_60426a03_crop_real_prft.map(19:20, 42:43,:) ) ) / 4;

imag_5mV_fex = sum ( sum ( obj_60426a04_crop_imag_prft.map(19:20, 19:20,:) ) ) / 4;
imag_5mV_fey = sum ( sum ( obj_60426a04_crop_imag_prft.map(19:20, 42:43,:) ) ) / 4;

real_5mV_fex = sum ( sum ( obj_60426a04_crop_real_prft.map(19:20, 19:20,:) ) ) / 4;
real_5mV_fey = sum ( sum ( obj_60426a04_crop_real_prft.map(19:20, 42:43,:) ) ) / 4;


figure, plot(-50,imag_50mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold on
plot(-20,imag_20mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-10,imag_10mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-5,imag_5mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 

plot(-50,imag_50mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-20,imag_20mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-10,imag_10mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-5,imag_5mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold off


figure, plot(-50,real_50mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold on
plot(-20,real_20mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-10,real_10mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-5,real_5mV_fex,'Marker', '+',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 

plot(-50,real_50mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-20,real_20mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-10,real_10mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
plot(-5,real_5mV_fey,'Marker', 'x',...
    'MarkerSize', 20,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2); 
hold off
