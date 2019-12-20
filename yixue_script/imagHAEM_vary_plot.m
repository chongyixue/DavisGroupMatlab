

%2017/10/21 Yi Xue Chong, Rahul Sharma
%in analysis for HAEM scheme, center of defect might be shifted
%this function plots a grid of different center and returns new center
%by minimizing imaginary part of one energy point around a q vector 2x2 box

function [newcx,newcy,imagmat] = imagHAEM_vary_plot(topo,map,qx,qy,cx,cy,pix_range,sstep)

%pix_range say 3 means 7x7 pixel area
%ssteps is the smallest we want to move 

max_steps = round(pix_range/sstep);

imagmat = zeros(2*max_steps+1,2*max_steps+1);

for i = -max_steps:max_steps
    for j = -max_steps:max_steps
        imagmat(j+max_steps+1,i+max_steps+1)=abs(imagpartHAEM(cx+i*sstep,cy+j*sstep,qx,qy,2,topo,map,1));
    end
end

A = imagmat;
[M,I] = min(A);
[~,II] = min(M);

downindex = I(II);
rightindex = II;
%A(downindex,rightindex);

%len = length(A);
TLx = cx-pix_range;
TLy = cy-pix_range;

newcx = TLx + (rightindex-1)*(sstep);
newcy = TLy + (downindex-1)*(sstep);

%mat2STM_Viewer(imagmat,0,0,1);

end

