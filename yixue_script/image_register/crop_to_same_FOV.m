% 2020-4-8 YXC
% crop two topo to same FOV given the point of references from each


function [newtopo1,newtopo2,t1x1,t1y1,t1x2,t1y2,t2x1,t2y1,t2x2,t2y2] = crop_to_same_FOV(topo1,x1,y1,topo2,x2,y2)

[nx,~,~] = size(topo1.map);
[t1x1,t2x1]=startingpoint(x1,x2);
[t1y1,t2y1]=startingpoint(y1,y2);

num = max([t1x1,t2x1,t1y1,t2y1]);
num = nx-num;

t1x2 = num+t1x1;
t1y2 = num+t1y1;
t2x2 = num+t2x1;
t2y2 = num+t2y1;

newtopo1 = croptopo(topo1,t1x1,t1x2,t1y1,t1y2);
newtopo2 = croptopo(topo2,t2x1,t2x2,t2y1,t2y2);



    function [p1,p2] = startingpoint(x1,x2)
       p1 = 1;
       p2 = 1+x2-x1;
       if p2<1
           p1 = 1+1-(p2);
           p2=1;
       end
    end


    function newtopo=croptopo(data,x1,x2,y1,y2)

%         [nr nc nz] = size(data.map);
        img = data.map;
        

        new_img = crop_img(img,y1,y2,x1,x2);
        

            new_data = data;
            new_data.map = new_img;
            new_data.ave = squeeze(mean(mean(new_img)));
            new_data.r = data.r(1:(x2-x1)+1);
            new_data.var = [new_data.var '_crop'];
            new_data.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
%             img_obj_viewer_test(new_data);
        newtopo = new_data;
        
    end
end


