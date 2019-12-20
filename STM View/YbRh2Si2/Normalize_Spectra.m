y = SB063_avg.avg(330:end);
x = 1:length(y);
p = polyfit(x,y',1);
f = polyval(p,x);
y_end = f(end);
figure; plot(x,y'); 

SB063_avg.norm = SB063_avg.avg/y_end;
figure; plot(SB063_avg.energy,SB063_avg.norm);
%%
figure; plot(SB0_avg.energy,SB0_avg.avg*1.5, 'k');
hold on; plot(SB06_avg.energy,SB06_avg.avg*1.5,'b');
hold on; plot(SB2_avg.energy,SB2_avg.avg,'g');
hold on; plot(SB4_avg.energy,SB4_avg.avg,'r');
hold on; plot(SB8_avg.energy,SB8_avg.avg,'r');


%%
figure; 
plot(SB0_avg.energy,SB0_avg.norm,'Color','y');

hold on; plot(SB052_avg.energy,SB052_avg.norm,'Color','m');
hold on; plot(SB058_avg.energy,SB058_avg.norm,'Color','g');
%hold on; plot(SB063_avg.energy,SB063_avg.norm,'Color','b');
hold on; plot(SB066_avg.energy,SB066_avg.norm,'Color','r');
%hold on; plot(SB08_avg.energy,SB08_avg.norm,'Color','r');
hold on; plot(SB2_avg.energy,SB2_avg.norm,'Color','k');
%hold on; plot(SB4_avg.energy,SB4_avg.norm,'Color','b');
%hold on; plot(SB8_avg.energy,SB8_avg.norm,'Color','k');

%%
figure; 
sp = 3;
plot(SB066_avg.energy,interp1(SB0_avg.energy,SB0_avg.norm,SB066_avg.energy),'Color','r');
hold on; plot(SB052_avg.energy,smooth(SB052_avg.norm,sp),'Color','m');
hold on; plot(SB058_avg.energy,smooth(SB058_avg.norm,sp),'Color','g');
hold on; plot(SB066_avg.energy,smooth(SB066_avg.norm,sp),'Color','b');
hold on; plot(SB08_avg.energy,smooth(SB08_avg.norm,sp),'Color','k');
%hold on; plot(SB2_avg.energy,smooth(SB2_avg.norm,2),'Color','k');
%hold on; plot(SB4_avg.energy,smooth(SB4_avg.norm,sp),'Color','b');
%hold on; plot(SB8_avg.energy,smooth(SB8_avg.norm,2),'Color','k');
%%
figure; plot(SB0_avg.energy,SB0_avg.norm - SB0_avg.norm,'k');
hold on; plot(SB1_avg.energy,SB1_avg.norm -  interp1(SB0_avg.energy,SB0_avg.norm,SB1_avg.energy),'b');
hold on; plot(SB2_avg.energy,SB2_avg.norm -  interp1(SB0_avg.energy,SB0_avg.norm,SB2_avg.energy),'g');
hold on; plot(SB4_avg.energy,SB4_avg.norm -  interp1(SB0_avg.energy,SB0_avg.norm,SB4_avg.energy),'r');
%% change in spectra from one field to the next
sp = 30;
figure;
hold on; plot(SB06_avg.energy,smooth(SB06_avg.norm -  interp1(SB0_avg.energy,SB0_avg.norm,SB06_avg.energy),sp),'ro');
hold on; plot(SB2_avg.energy,smooth(SB08_avg.norm -  SB06_avg.norm,sp),'y*');
hold on; plot(SB2_avg.energy,smooth(SB2_avg.norm -  SB08_avg.norm,sp),'gx');
hold on; plot(SB4_avg.energy,smooth(SB4_avg.norm -  SB2_avg.norm,sp),'b+');
hold on; plot(SB8_avg.energy,smooth(SB8_avg.norm -  SB4_avg.norm,sp),'k+');
%%
%% change in spectra from QC field B = 0.66T
sp = 30;
figure;
hold on; plot(SB06_avg.energy,smooth(SB06_avg.norm -  interp1(SB0_avg.energy,SB0_avg.norm,SB06_avg.energy),sp),'ro');
hold on; plot(SB2_avg.energy,smooth(SB08_avg.norm -  SB06_avg.norm,sp),'y*');
hold on; plot(SB2_avg.energy,smooth(SB2_avg.norm -  SB06_avg.norm,sp),'gx');
hold on; plot(SB4_avg.energy,smooth(SB4_avg.norm -  SB06_avg.norm,sp),'b+');
hold on; plot(SB8_avg.energy,smooth(SB8_avg.norm -  SB06_avg.norm,sp),'k+');


%%
e8 = SB8_avg.avg(end);
e4 = SB4_avg.avg(end);
e2 = SB2_avg.avg(end);
e1 = SB1_avg.avg(end)*1.5;
e0 = SB0_avg.avg(end)*1.5;

 figure; plot(SB8_avg.energy,SB8_avg.avg,'k');
 hold on; plot(SB4_avg.energy,SB4_avg.avg+(e8-e4),'b');
 hold on; plot(SB2_avg.energy,SB2_avg.avg+(e8-e2),'g');
 hold on; plot(SB1_avg.energy,SB1_avg.avg*1.5+(e8-e1),'r');
 hold on; plot(SB0_avg.energy,SB0_avg.avg*1.5+(e8-e0),'m');