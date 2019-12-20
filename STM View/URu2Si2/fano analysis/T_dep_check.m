figure;

plot(data_19K.e,data_19K.spect*data_19K.jr); hold on;
plot(data_17K.e,data_17K.spect*data_17K.jr,'r'); hold on;
plot(data_15K.e,data_15K.spect*data_15K.jr,'g'); hold on;
plot(data_10K.e,data_10K.spect*data_10K.jr,'k'); hold on;
plot(data_6K.e,data_6K.spect*data_6K.jr,'m'); hold on;
plot(data_2K.e,data_2K.spect*data_2K.jr,'c'); hold on;

%%
figure;
plot(data_19K_mod.e,data_19K_mod.spect); hold on;
plot(data_17K_mod.e,data_17K_mod.spect,'r'); hold on;
plot(data_15K_mod.e,data_15K_mod.spect,'g'); hold on;
plot(data_10K_mod.e,data_10K_mod.spect,'k'); hold on;
plot(data_6K_mod.e,data_6K_mod.spect,'m'); hold on;
plot(data_2K_mod.e,data_2K_mod.spect,'c'); hold on;
%%
figure;
plot(data_19K_mod.e, data_17K_mod.spect./data_19K_mod.spect,'r'); hold on;
plot(data_19K_mod.e, data_15K_mod.spect./data_19K_mod.spect,'g');
plot(data_19K_mod.e, data_10K_mod.spect./data_19K_mod.spect,'k');
plot(data_19K_mod.e, data_6K_mod.spect./data_19K_mod.spect,'m');
plot(data_19K_mod.e, data_2K_mod.spect./data_19K_mod.spect,'c');