% 2019-7-11 YXC
% script guide for running machine learning codes
% 0. save a cvs file with heading coord,1,2,.... to 101,left,right (#of spectrum=101 in this example)
% 1. run     gapmap_fesete_function
% 2. run     gapmap_export_all_spectra(map,varargin)
% 3. go to python and run (and change some parameters)recognize_scgap.py
% 4. run     gapmap_view_learnt_prediction


% FST90708
gapmap_fesete_function(obj_90708a00_G,'name','FST90708')
gapmap_fesete_function(obj_90708a00_G,'suffix','FST')
gapmap_fesete_function(obj_90708a00_G) %need improvement of this one

gapmap_export_all_spectra(obj_90708a00_G,'name','FST90708')
gapmap_export_all_spectra(obj_90708a00_G,'suffix','FST')

gapmap_view_learnt_prediction(obj_90708a00_G,'suffix','FST')
gapmap_view_learnt_prediction(obj_90708a00_G)

% FST40401
gapmap_fesete_function(obj_40401A00_G,'name','FST40401')
gapmap_fesete_function(obj_40401A00_G,'suffix','FST')

gapmap_export_all_spectra(obj_40401A00_G,'name','FST40401')

gapmap_view_learnt_prediction(obj_40401A00_G,'suffix','FST')
