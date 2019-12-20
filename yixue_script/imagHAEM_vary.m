%2017/10/21
%%comment this section out after the first iteration
qx = 57;
qy = 49;
map = obj_71001a01_G;
topo = obj_71001A01_T;



cx = 61;
cy = 67;

pix_range = 1;
sstep = pix_range*0.1;


%pix_range say 3 means 7x7 pixel area
%ssteps is the smallest we want to move 
[newcx,newcy,imagmat]=imagHAEM_vary_plot(topo,topo,qx,qy,cx,cy,pix_range,sstep);

mat2STM_Viewer(imagmat,0,0,1);

check = 0;
counter = 0;

while check == 0
    
    if abs(newcx-cx) > pix_range-1 ||  abs(newcy-cy)>pix_range-1
        pix_range=pix_range*10;
        %print = "BIGGER"
    else
        pix_range = pix_range*0.1;
        %print = "SMALLER"
    end
    sstep = pix_range*0.1;
    
    if newcx<0 || newcy<0
        check = 1;
    end
    
    
    cx = newcx;
    cy = newcy;
    
    [newcx,newcy,imagmat]=imagHAEM_vary_plot(topo,topo,qx,qy,cx,cy,pix_range,sstep);

    
    counter = counter +1;
    if counter == 4
        check = 1;
    end
end
    
    



mat2STM_Viewer(imagmat,0,0,1);


