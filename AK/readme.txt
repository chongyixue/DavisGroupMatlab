Short readme to the matlab code:

1) load the parameters from the data file (matlab file)
load t1.mat

2) optional: set the spin-orbit coupling (SzLz for fitting purposes) 
to zero
if SOC is added later with the full S*L term.

t1(50)=0;

3) call the function with the known arguments + the additional argument
 for
the parameters

function [eigeps2Daa,eigeps2Dss] = fese_Hirschfeld_tb_5orbital_bounds_unres_mexable_as(pixelnum, kz, kx_limits, ky_limits ,t1)

[if t1 is skipped, 
the code loads for each call the variable from the file
t1.mat of the current directory]

*) For faster running, the code can also be "mexed", e.g. translated 
to a c++
code; should work with the additional script

mex_fese_Hirschfeld_tb_5orbital_bounds_unres_mexable_as

Then, the function 
call has to be changed to:

function [eigeps2Daa,eigeps2Dss] = fese_Hirschfeld_tb_5orbital_bounds_unres_mexable_as_mex(pixelnum, kz, kx_limits, ky_limits ,t1)
