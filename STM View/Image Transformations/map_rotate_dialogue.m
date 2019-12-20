function map_rotate_dialogue(data)
   prompt={'Rotation Angle'};
   name='Map Rotation Parameter';
   numlines=1;
   defaultanswer= {'0'};
   answer = inputdlg(prompt,name,numlines,defaultanswer); 
   angle = str2double(answer);
   if isempty(angle)
       return;
   end
   map_rotate(data,angle);
end