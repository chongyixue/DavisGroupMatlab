function [gmap, impmap, valarra]=FeTeSe_gapmap_combine_v2(gmap1, impmap1, valarra1,...
    gmap2, impmap2, valarra2,gmap3, impmap3, valarra3,gmap4, impmap4, valarra4)
%% Extract the gap from a spectroscopic map for each 
%% individual pixel.
%% data is the struct containing the map
%% offset is a numeric value to correct an offset in the voltage during the 
%% measurement
%% antigap contains 6 or 4 energy values, 2 (or 1) pairs defining the positions of the 
%% coherence peaks in the average spectrum, and 1 that determines the energy 
%% region for the in-gap states. If the average LDOS inside the gap is higher 
%% than the average LDOS at the coherence peaks the gap-value at this location 
%% will be set to zero. This will prevent attempts of trying to determine a gap 
%% with not strong gap features in the tunnel spectrum.

valarra.cpbs = cat(1,valarra1.cpbs,valarra2.cpbs,valarra3.cpbs,valarra4.cpbs);
valarra.cpas = cat(1,valarra1.cpas,valarra2.cpas,valarra3.cpas,valarra4.cpas);
valarra.cpsmean = cat(1,valarra1.cpsmean,valarra2.cpsmean,valarra3.cpsmean,valarra4.cpsmean);
valarra.cpb = cat(1,valarra1.cpb,valarra2.cpb,valarra3.cpb,valarra4.cpb);
valarra.cpa = cat(1,valarra1.cpa,valarra2.cpa,valarra3.cpa,valarra4.cpa);
valarra.cpmean = cat(1,valarra1.cpmean,valarra2.cpmean,valarra3.cpmean,valarra4.cpmean);
valarra.ssb = cat(1,valarra1.ssb,valarra2.ssb,valarra3.ssb,valarra4.ssb);
valarra.ssa = cat(1,valarra1.ssa,valarra2.ssa,valarra3.ssa,valarra4.ssa);
valarra.ssmean = cat(1,valarra1.ssmean,valarra2.ssmean,valarra3.ssmean,valarra4.ssmean);
valarra.impb = cat(1,valarra1.impb,valarra2.impb,valarra3.impb,valarra4.impb);
valarra.impa = cat(1,valarra1.impa,valarra2.impa,valarra3.impa,valarra4.impa);
valarra.impmean = cat(1,valarra1.impmean,valarra2.impmean,valarra3.impmean,valarra4.impmean);

gmapa = cat(2,gmap1,gmap2);
gmapb = cat(2,gmap3,gmap4);
gmap = cat(1,gmapa,gmapb);

impmapa = cat(2,impmap1,impmap2);
impmapb = cat(2,impmap3,impmap4);
impmap = cat(1,impmapa,impmapb);

end
