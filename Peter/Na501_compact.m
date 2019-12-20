%% create Fourier Transform

FFT = load_map_qpi('C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_01_13\NaFeAs30501A00.mat',...
    'feenstra','','vh','',0,0,0,0);
% for inputs see load_map_qpi
%% take cut and the polar average

[ln_cut,O]=qpi_cut(FFT,4,45);
% first input FFT, second input offset from center for taking cuts, and
% third input angle at which the cut is taken

%% fit the cut
% inputs: 
peakpos{1}=40;
peakpos{2}=[33,60];
peakpos{3}=[31, 62, 95];
qpi_fit(O,4,[2, 4, 8, 24],{'s','d','t'},peakpos,FFT)
%% plot all the energy layers in the cut
for k=1:length(O(1,:))
    x=1:1:length(O(:,k));
    y=O(:,k);
    z(:,1)=x;
    z(:,2)=y;
    data=ftsmooth(z,'n',7,3);
    figure;
    plot(z(:,1),(z(:,2)),'r',data(:,1),(data(:,2)),'k','Linewidth',2)
end
