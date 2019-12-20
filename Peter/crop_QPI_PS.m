function [nG, nI, nIF, nT] = crop_QPI_PS(datacell)

G = datacell{1};
I = datacell{2};
IF = datacell{3};
T = datacell{4};


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
%     nG.e = nG.e + enoff;
    
    nI=I;
    nI.map = nI.map(xs:xe,ys:ye,:);
    nI.ave = squeeze(sum(sum(nI.map)))/s/s; 
    nI.r = r;
%     nI.e = nI.e + enoff;
    
    nT=T;
    nT.map = nT.map(xs:xe,ys:ye,:);
    nT.r = r;

    
    nIF=IF;
    nIF.map = nIF.map(xs:xe,ys:ye,:);
    nIF.r = r;


end