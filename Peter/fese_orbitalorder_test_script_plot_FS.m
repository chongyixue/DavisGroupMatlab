pixelnum = 500;
kz = 0;

%% test orbital order 1
% [eigeps2D1, orbcha1] = fese_Hirschfeld_tb_test_OO1(pixelnum, kz, oos, oodfe, soc)
[eigeps2D1, orbcha1] = fese_Hirschfeld_tb_test_OO1(pixelnum, kz, 0.0096, 0.0089, 0.02);


A1 = fese_fs_plot(eigeps2D1, orbcha1);


%% test orbital order 2
% [eigeps2D2, orbcha2] = fese_Hirschfeld_tb_test_OO2(pixelnum, kz, oos, oodfe, soc)
[eigeps2D2, orbcha2] = fese_Hirschfeld_tb_test_OO2(pixelnum, kz, 0.0096, 0.0089, 0.02);


A2 = fese_fs_plot(eigeps2D2, orbcha2);