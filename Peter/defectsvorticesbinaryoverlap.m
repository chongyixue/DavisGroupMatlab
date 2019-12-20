function allareas=defectsvorticesbinaryoverlap(mbdmap,msdmapco,onesig,twosig)


onesigolbig = (mbdmap + onesig)/2;
twosigolbig = (mbdmap + twosig)/2;

figure, img_plot5(onesigolbig);
figure, img_plot5(twosigolbig);




onesigolbig = im2bw(onesigolbig,0.5);
twosigolbig = im2bw(twosigolbig,0.5);

figure, img_plot5(onesigolbig);
figure, img_plot5(twosigolbig);

onesigolsm = (msdmapco + onesig)/2;
twosigolsm = (msdmapco + twosig)/2;


figure, img_plot5(onesigolsm);
figure, img_plot5(twosigolsm);

onesigolsm = im2bw(onesigolsm,0.5);
twosigolsm = im2bw(twosigolsm,0.5);

figure, img_plot5(onesigolsm);
figure, img_plot5(twosigolsm);


allareas.onesigarea = bwarea(onesig);
allareas.twosigarea = bwarea(twosig);
allareas.onesigareaolbig = bwarea(onesigolbig);
allareas.twosigareaolbig = bwarea(twosigolbig);
allareas.onesigareaolsm = bwarea(onesigolsm);
allareas.twosigareaolsm = bwarea(twosigolsm);

allareas.onesigbigpc = allareas.onesigareaolbig/allareas.onesigarea;
allareas.onesigsmpc = allareas.onesigareaolsm/allareas.onesigarea;
allareas.onesigfreepc = 1 - allareas.onesigbigpc - allareas.onesigsmpc;

allareas.twosigbigpc = allareas.twosigareaolbig/allareas.twosigarea;
allareas.twosigsmpc = allareas.twosigareaolsm/allareas.twosigarea;
allareas.twosigfreepc = 1 - allareas.twosigbigpc - allareas.twosigsmpc;

end