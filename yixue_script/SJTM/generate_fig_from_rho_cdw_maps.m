% 2020-4-20 YXC
% given a registered image of rho and cdw maps, generate phase plots etc

% Braggs are in the form of Braggs(braggnumber,:)=[x,y];

function generate_fig_from_rho_cdw_maps(rhomap,cdwmap,Braggs,varargin)

nvarargin = length(varargin);

nx = size(rhomap.map,2);
center = ceil((nx+1)/2);
nperiod = sqrt(sum((Braggs(1,:)-[center,center]).^2));


%% default properties
sigma = 


for i=1:nvarargin
    switch varargin{i}
        case 'sigma' % sigma in real space
            
            
            
        case 'circle'


        case 'colormap'








end












