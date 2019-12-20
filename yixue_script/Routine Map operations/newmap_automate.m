% the purpose of this script is to generate the required movies/images for
% powerpoint presentation of map.
% required items are
% 1. original map + FT movie - adjust histogram in the middle-ask user
% 2. Topo + FT -save as png
% 3. average spectrum
% 2018-09-22

function newmap_automate(map,topo,pathname)
if length(map.e)>1
    if map.e(2)-map.e(1)<0
        %reverse all layers
        layers = size(map.map,3);
        map.ave = fliplr(map.ave);
        map.e = fliplr(map.e);
        holder = map.map;
        for n = 1:layers
            map.map(:,:,n) = holder(:,:,layers-n+1);
        end
    end
end




filename = map.name;
if contains(map.var,'crop')==1
    filename = [filename, 'crop'];
end
filename = [filename , '_map'];

word = '';
%don't write over file if already exist add number at the end
if exist([filename, '_auto.mp4'],'file')==2
    add1 = 1;
    number = 0;
    while add1 == 1
        number = number + 1;
        word = num2str(number);
        if length(word)<2
            word = ['_0', word];
        else 
            word = ['_', word];
        end
        if exist([filename,word,'_auto.mp4'],'file')~=2
            add1 = 0;
        end
    end
end
filename = [filename,word];
                      

Rspace_name = img_obj_viewer_test(map);

%deal with map first - subtract background 0 for FT
subback0map = polyn_subtract(map,0,3); %something on varargin(3):no-popup
FTmap = fourier_transform2d(subback0map,'sine','amplitude','ft');
FTmap.ave = [];
FTmap.var = [FTmap.var '_ft_amplitude'];
FTmap.ops{end+1} = 'Fourier Transform: amplitude - sine window - ft direction';
ft_name= img_obj_viewer_test(FTmap);

%prompt user to adjust histogram then click ok
fh=figure('Name', 'Adjust histograms of both maps to your liking',...
    'NumberTitle', 'off',...
    'units','centimeter', ...
    'Position',[1,5,10,2],...
    'Color',[0.6 0 1],...
    'MenuBar', 'none');
Histograms_adjusted_but = uicontrol(fh,'Style','pushbutton',...
    'String','Histogram adjusted, Export Map!',...
    'units','normalized',...
    ...%'Position',[0.75 0.1 0.2 0.3],...
    'Position',[0.25 0.4 0.6 0.5],...
    'Callback',{@adjust_histogram_Callback});


topoR = img_obj_viewer_test(topo);
topoFT = fourier_transform2d(polyn_subtract(topo,0,3),'sine','amplitude','ft');
topoFT.var = [topoFT.var '_ft_amplitude'];
topoFT.ops{end+1} = 'Fourier Transform: amplitude - sine window - ft direction';
topoFT_name = img_obj_viewer_test(topoFT);


%% show average spectrum
data = guidata(get_handle_tag(Rspace_name));
x = data.e*1000;
y = data.ave;
%         if ~isempty(data.ave)
%             y = data.ave;
%         else
%             y = squeeze(mean(mean(data.map)));
%         end

[nx ny nz] = size(data.map);
for i=1:nz
    tf = isfield(data,'regions');
    if tf == 0
        datvec = reshape(data.map(:,:,i),nx*ny,1);
        datstd(i) = std(datvec);
        clear datvec;
    else
        if isfield(data,'iclmask')==1
            M = data.iclmask;
        else
            M = data.xclmask;
        end
        cc = 1;
        for k=1:nx
            for l=1:ny
                if M(k,l)==1
                    datvec(cc) = data.map(k,l,i);
                    cc = cc+1;
                end
            end
        end
        datstd(i) =std(datvec);
        clear datvec;
    end
end
graph_plot(x,y,datstd','b',[data.name ' Average Spectrum']);

%%%%%%%%%%%%%%%%%%%%%%%%%Callback Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    function adjust_histogram_Callback(hObject,evendata)
        auto_export(Rspace_name,ft_name,pathname,filename)
        %close figure after movie saved
        %close(Rspace_name)
        %close(ft_name)
        close(fh)
    end
    
    
end
