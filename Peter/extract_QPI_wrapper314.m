load D:/URU2Si2/G90314A13cut_struct.mat
%load D:/URU2Si2/G90314A13fit_struct.mat
load D:/URU2Si2/G90314A13QPI_struct.mat
extraction_viewer_tool3(cut_struct,[],QPInocore);

%or if fit structure exists
%extraction_viewer_tool3(cut_struct,fit,QPInocore);