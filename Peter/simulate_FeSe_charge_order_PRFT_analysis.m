
%% test with all 12 amplitudes having the same magnitude := 1

ampllist = ones(1, 12);

[topo_rec_comp, topo_rec_comp_sum] = simulate_FeSe_charge_order(250, ampllist);

[real_prft_comp, imag_prft_comp, real_prft_comp_sum, imag_prft_comp_sum] = ...
    simulate_charge_prft_analysis(topo_rec_comp, topo_rec_comp_sum);


%% 60426A01_T

% (1, 0)
ampllist_a01(1) = -251;

% (0, 1)
ampllist_a01(2) = 262;

% (1, 1)
ampllist_a01(3) = 25;

% (1, -1)
ampllist_a01(4) = 26;

% (2, 0)
ampllist_a01(5) = 0;

% (0, 2)
ampllist_a01(6) = 16;

% (2, 1)
ampllist_a01(7) = -3;

% (2, -1)
ampllist_a01(8) = -4;

% (1, 2)
ampllist_a01(9) = 6;

% (1, -2)
ampllist_a01(10) = 0;

% (2, 2)
ampllist_a01(11) = 0;

% (2, -2)
ampllist_a01(12) = 0;

[topo_rec_comp_a01, topo_rec_comp_sum_a01] = simulate_FeSe_charge_order(250, ampllist_a01);

[real_prft_comp_a01, imag_prft_comp_a01, real_prft_comp_sum_a01, imag_prft_comp_sum_a01] = ...
    simulate_charge_prft_analysis(topo_rec_comp_a01, topo_rec_comp_sum_a01);

%% 60426A02_T

% (1, 0)
ampllist_a02(1) = -423;

% (0, 1)
ampllist_a02(2) = 655;

% (1, 1)
ampllist_a02(3) = 71;

% (1, -1)
ampllist_a02(4) = 13;

% (2, 0)
ampllist_a02(5) = -4;

% (0, 2)
ampllist_a02(6) = -69;

% (2, 1)
ampllist_a02(7) = 16;

% (2, -1)
ampllist_a02(8) = 1;

% (1, 2)
ampllist_a02(9) = -24;

% (1, -2)
ampllist_a02(10) = -11;

% (2, 2)
ampllist_a02(11) = 0;

% (2, -2)
ampllist_a02(12) = 8;

[topo_rec_comp_a02, topo_rec_comp_sum_a02] = simulate_FeSe_charge_order(250, ampllist_a02);

[real_prft_comp_a02, imag_prft_comp_a02, real_prft_comp_sum_a02, imag_prft_comp_sum_a02] = ...
    simulate_charge_prft_analysis(topo_rec_comp_a02, topo_rec_comp_sum_a02);

%% 60426A03_T

% (1, 0)
ampllist_a03(1) = -729;

% (0, 1)
ampllist_a03(2) = 897;

% (1, 1)
ampllist_a03(3) = 170;

% (1, -1)
ampllist_a03(4) = 23;

% (2, 0)
ampllist_a03(5) = -73;

% (0, 2)
ampllist_a03(6) = -106;

% (2, 1)
ampllist_a03(7) = 42;

% (2, -1)
ampllist_a03(8) = -11;

% (1, 2)
ampllist_a03(9) = -33;

% (1, -2)
ampllist_a03(10) = 0;

% (2, 2)
ampllist_a03(11) = -11;

% (2, -2)
ampllist_a03(12) = 0;

[topo_rec_comp_a03, topo_rec_comp_sum_a03] = simulate_FeSe_charge_order(250, ampllist_a03);

[real_prft_comp_a03, imag_prft_comp_a03, real_prft_comp_sum_a03, imag_prft_comp_sum_a03] = ...
    simulate_charge_prft_analysis(topo_rec_comp_a03, topo_rec_comp_sum_a03);

%% 60426A04_T

% (1, 0)
ampllist_a04(1) = -1236;

% (0, 1)
ampllist_a04(2) = 1125;

% (1, 1)
ampllist_a04(3) = 283;

% (1, -1)
ampllist_a04(4) = 30;

% (2, 0)
ampllist_a04(5) = -221;

% (0, 2)
ampllist_a04(6) = -151;

% (2, 1)
ampllist_a04(7) = 85;

% (2, -1)
ampllist_a04(8) = 12;

% (1, 2)
ampllist_a04(9) = -51;

% (1, -2)
ampllist_a04(10) = 4;

% (2, 2)
ampllist_a04(11) = -13;

% (2, -2)
ampllist_a04(12) = 4;

[topo_rec_comp_a04, topo_rec_comp_sum_a04] = simulate_FeSe_charge_order(250, ampllist_a04);

[real_prft_comp_a04, imag_prft_comp_a04, real_prft_comp_sum_a04, imag_prft_comp_sum_a04] = ...
    simulate_charge_prft_analysis(topo_rec_comp_a04, topo_rec_comp_sum_a04);