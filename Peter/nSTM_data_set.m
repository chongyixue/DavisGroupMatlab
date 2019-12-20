function [nG, nI, nT, nIF, nFG, nOLGC]=nSTM_data_set(G, I, T, IF, enoff)
%% Function to crop the complete data set, make the number of pixels odd to get
%% a symmetrical FT and correct for a possible offset in energy with "enoff"
%% , and create normalized conductance maps: Feenstra (dI/dV)/I(V) || 
%% normalized by one manually chosen layer (dI/dV)/I(V=const).
%% 02/24/14 Peter Sprau

% Open the map to check if it actually needs to be cropped. You need to
% type "return" into the command line window and press return / enter to
% continue execution of the function.
img_obj_viewer2(G);
keyboard

% Asks for the coordinates used to crop the data
prompt = {'xstart:','ystart:','xend','yend'};
dlg_title = 'Crop with following coordinates (no crop -> push cancel);';
num_lines = 1 ;
def = {'1','1','1','1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

% Either crop or continue without cropping. Make sure the number of lines
% and rows is odd after cropping to get a symmetrical FT.
if ~isempty(answer)
    % Exchange 2 for 1 and 4 for 3 to get usual x-y-coordinate system
    xs = str2num(answer{2});
    ys = str2num(answer{1});
    xe = str2num(answer{4});
    ye = str2num(answer{3});
else
    [nx ny nz] = size(G.map);
    xs = 1;
    ys = 1;
    xe = nx;
    ye = ny;
end
    
    % Make an even number of pixels odd. r gives the real space values (1
    % nm , 2nm ,... or 1 Angstroem, 2 Angstroem, ... etc.)
    r = G.r;
    if mod(abs(xs-xe),2) == 0  
        r = r(1:abs(xs-xe)+1);
    else
        xe = xe - 1;
        ye = ye - 1;
        r = r(1:abs(xs-xe)+1);
    end
    
    % Write the new (possibly cropped) data into nG, nI, nT and nIF
    nG=G;
    nG.map = nG.map(xs:xe,ys:ye,:);
    [nx ny nz] = size(nG.map);
    s = nx;
    nG.ave = squeeze(sum(sum(nG.map)))/s/s; 
    nG.r = r;
    nG.e = nG.e + enoff;
    
    nI=I;
    nI.map = nI.map(xs:xe,ys:ye,:);
    nI.ave = squeeze(sum(sum(nI.map)))/s/s; 
    nI.r = r;
    nI.e = nI.e + enoff;
    
    nT=T;
    nT.map = nT.map(xs:xe,ys:ye,:);
    nT.r = r;

    
    nIF=IF;
    nIF.map = nIF.map(xs:xe,ys:ye,:);
    nIF.r = r;

    % Initialize the Feenstra data set
    nFG=nG;
    
    % Create the Feenstra data set and a string containing all energy
    % layers used in the listdlg that asks for the current layers used for
    % normalization
    for i=1:size((nG.e), 2)
    str{i} = num2str(nG.e(i));
    nFG.map(:,:,i) = nFG.map(:,:,i)./nI.map(:,:,i);
    end
    
    % Choose the current layers to normalize the data to
    [s,v] = listdlg('PromptString','Select energy layers in meV to normalize to:',...
                'SelectionMode','multiple',...
                'ListString',str);
    
    % Create the to one current layer normalized data
    nOLG = nG;
    nOLGC = {};
    if v ==1 
        for i=1:size(s, 2)
            for j=1:size((nG.e), 2)
                olmap(:,:,j) = nG.map(:,:,j)./nI.map(:,:,s(i));
            end
            nOLG.map = olmap;
            nOLGC{i} = nOLG;
            clear olmap;
        end
          
    end

          
end