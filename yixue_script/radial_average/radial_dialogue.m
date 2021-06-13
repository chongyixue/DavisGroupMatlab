function radial_dialogue(data)

[nx,~,~] = size(data.map);
x = linspace(1,nx,nx);
[X,Y] = meshgrid(x);
% center = fix(nx/2)+1;
center = ceil((nx+1)/2);
X = X-center;
Y = Y-center;
nx = num2str(nx);
prompt = {'starting pixel (from middle = 0)','end pixel','angle_start(0:right-360)','angle_end',...
    'center_xpx','center_ypx'};
dlg_title = 'radially symmetric linecut';
default_answer = {'0',nx,'0','0',num2str(center),num2str(center)};
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
        centerx = str2double(answer{6});
        centery = str2double(answer{5});
        radial_plot(data,startpix,endpix,startangle,endangle,centerx,centery);
        
        angle = atan2(Y,X)*180/pi;
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