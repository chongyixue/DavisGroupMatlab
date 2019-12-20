function nematic_tile_dialogue(data)
prompt={'Tile Size (pixels)'};
name='Nematic Tile I Options';
numlines=1;         
defaultanswer={'0'};
answer = inputdlg(prompt,name,numlines,defaultanswer);
new_img = nematic_tile(data.map,str2double(answer));
new_data = data;
new_data.map = new_img;
new_data.ops{end+1} = ['Nematic Tiled with ' answer ' pixels.'];
img_obj_viewer2(new_data);
end