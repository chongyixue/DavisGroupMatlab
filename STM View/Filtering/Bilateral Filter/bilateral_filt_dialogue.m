function new_data = bilateral_filt_dialogue(data)
       prompt={'Specify Filter Window Size (px)','Specify Spatial Domain SD',...
           'Specify Intensity Domain SD'};
       name='Bilateral Filter Parameters';
       numlines=1;
       defaultanswer= {'1','0','0'};
       answer = inputdlg(prompt,name,numlines,defaultanswer); 
       w = str2double(answer{1});
       sigma(1) = str2double(answer{2});
       sigma(2) = str2double(answer{3});
       
       [nr nc nz] = size(data.map);
       new_map = zeros(nr,nc,nz);
       old_map = data.map;
      % h = waitbar(0,'Applying bilateral filter to Layers...');
      % set(h,'Name','Bilateral Filter Progress');       
       matlabpool(2);
       parfor i = 1:nz           
           img = old_map(:,:,i);
           max_val = max(max(img));
           new_map(:,:,i) = bilateral_filt(img/max_val,w,sigma)*max_val;
         %  waitbar(i/nz,h,[num2str(i/nz*100) '%']);
       end
       matlabpool close;
      % close(h);
       new_data = data;
       new_data.map = new_map;
       new_data.var = [new_data.var '_bi_filt'];
       new_data.ops{end+1} = ['Bilateral Filter - filter width: ' answer{1} ', spatial SD: ' answer{2} ', intensity SD: ' answer{2}];
       img_obj_viewer2(new_data);      
       
end