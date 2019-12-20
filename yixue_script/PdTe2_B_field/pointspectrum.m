
raw_data = test;

% h=1;
h=h+2;
color = {[0,0,1],[0,0.8,0.2],[0,0.6,0.4],[0.2,0.2,0.6],[0.4,0.4,0.2],[0.8,0.1,0.1],[0.5,0.5,0]};



v = raw_data(1:2:end);
v = v(265:end);
energy = v(1:length(v)/2);
energy = energy*1000;

offset = 0;
energy = energy + offset;



data=raw_data(2:2:end);
data=data(265:end);

%parse out current/conductance data
data=raw_data(2:2:end);
data=data(265:end);



fwd = data(1:length(data)/2);
bkwd = data(length(data)/2+1:end);

%
figure,
plot(energy,fwd,'.-','color',color{h},'linewidth',1)
hold on
plot(energy,bkwd,'.-','color',color{h+1},'linewidth',1)
hold on
% axis([min(energy) max(energy) min(min([fwd,bkwd])) max(max([fwd,bkwd]))])
axis([min(energy) max(energy) 0 20])
xlabel('V [mV]','fontsize',12,'fontweight','b')