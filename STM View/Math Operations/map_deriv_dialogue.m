function map_deriv_dialogue(data)
       prompt={'Specify Derivative Order'};
       name='Map Derivative in Energy';
       numlines=1;
       defaultanswer= {'1'};
       answer = inputdlg(prompt,name,numlines,defaultanswer); 
       der_order = str2double(answer);
       map_deriv(data,der_order,1);
end