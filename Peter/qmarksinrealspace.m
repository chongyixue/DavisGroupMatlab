function qmarksinrealspace(data,q1,q2,r)

atp = data.r(2)-data.r(1);
map = data.map;
[nx, ny, nz] = size(map);

alpha1 = acos(q1(1)/sqrt(q1(1)^2+q1(2)^2));
alpha2 = acos(q2(1)/sqrt(q2(1)^2+q2(2)^2));

lambda1 = (2*pi/sqrt(q1(1)^2+q1(2)^2))/atp;
lambda2 = (2*pi/sqrt(q2(1)^2+q2(2)^2))/atp;

x1 = lambda1 * cos(alpha1);
y1 = lambda1 * sin(alpha1);

x2 = lambda1 * cos(alpha2);
y2 = lambda1 * sin(alpha2);

x0 = r(1);
y0 = r(2);

change_color_of_STM_maps(map,'no')
hold on    

    for i=0:round(0.7*nx/lambda1)
        for j=0:round(0.7*ny/lambda2)
            
            x0 = r(1) + i*x1 + j*x2;
            y0 = r(2) + i*y1 + j*y2;
            
            if x0 >=1 && x0 <= nx && y0 >= 1 && y0 <= ny
                
                line([x0,x0],[y0,y0],'Color','c','LineWidth',4,'Marker','+','MarkerSize',10);
                
            end
            
            x0 = r(1) + i*x1 - j*x2;
            y0 = r(2) + i*y1 - j*y2;
            
            if x0 >=1 && x0 <= nx && y0 >= 1 && y0 <= ny
                
                line([x0,x0],[y0,y0],'Color','c','LineWidth',4,'Marker','+','MarkerSize',10);
                
            end
            
            x0 = r(1) - i*x1 + j*x2;
            y0 = r(2) - i*y1 + j*y2;
            
            if x0 >=1 && x0 <= nx && y0 >= 1 && y0 <= ny
                
                line([x0,x0],[y0,y0],'Color','c','LineWidth',4,'Marker','+','MarkerSize',10);
                
            end
            
            x0 = r(1) - i*x1 - j*x2;
            y0 = r(2) - i*y1 - j*y2;
            
            if x0 >=1 && x0 <= nx && y0 >= 1 && y0 <= ny
                
                line([x0,x0],[y0,y0],'Color','c','LineWidth',4,'Marker','+','MarkerSize',10);
                
            end
            
            test = 1;
            
        end
    end
    
hold off



% map = data.map;
% [nx, ny, nz] = size(map);
% 
% fw = max(max(map));
% 
% for i=1:nx
%     for j=1:ny
%         if map(i,j,1) ==0
%         else
%             map(i,j,1) = fw;
%             if isfield(data,'cpx_map')==1
%                 
%                     data.cpx_map(i,j,1) = max(max(data.cpx_map));
%             end
%             if isfield(data,'rel_map')==1
%                 
%                     data.rel_map(i,j,1) = max(max(data.rel_map));
%             end
%             if isfield(data,'img_map')==1
%                 
%                     data.img_map(i,j,1) = max(max(data.img_map));
%             end
%             if isfield(data,'apl_map')==1
%                 
%                     data.apl_map(i,j,1) = max(max(data.apl_map));
%             end
%             if isfield(data,'pha_map')==1
%                 
%                     data.pha_map(i,j,1) = max(max(data.pha_map));
%             end
%         end
%     end
% end
% 
% 
% 
% 
% 
% data.map = map;
% 
% img_obj_viewer2(data);
% 
% test=1;

end