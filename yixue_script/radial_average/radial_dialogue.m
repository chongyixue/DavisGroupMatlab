function radial_dialogue(data)

[nx,~,~] = size(data.map);
x = linspace(1,nx,nx);
[X,Y] = meshgrid(x);
% center = fix(nx/2)+1;
center = ceil((nx+1)/2);
X = X-center;
Y = Y-center;
nx = num2str(nx);
prompt = {'starting pixel (from middle = 1)','end pixel','angle_start(0:right-360)','angle_end'};
dlg_title = 'radially symmetric linecut';
default_answer = {'1',nx,'0','0'};
num_lines = 1;



while 1
    answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
    if isempty(answer)
        return
    else
        startpix = str2double(answer{1});
        endpix = str2double(answer{2});
        startangle = str2double(answer{3});
        endangle = str2double(answer{4});
        radial_plot(data,startpix,endpix,startangle,endangle);
        
        angle = atan2(Y,X)*180/3.141592653589793;
        angle = mod(angle,360);
        
        %add angle to mask
        startangle = mod(startangle,360);
        endangle = mod(endangle,360);
        
        % angle_mask is 1 if include
        if startangle == endangle
            angle_mask = angle<400; %(just all included)
        elseif endangle<startangle
            angle_mask = or(angle>startangle,angle<endangle);
        else
            angle_mask = and(angle>startangle,angle<endangle);
        end
        figure,imagesc(angle_mask);
        break
    end
end