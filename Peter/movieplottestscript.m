%%

writerObj = VideoWriter('C:\Users\Peter\Dropbox\51123A00_radius5\peaks.avi');
open(writerObj);

Z = peaks; 
figure, surf(Z); 
axis tight
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');

for k = 1:20 
   surf(sin(2*pi*k/20)*Z,Z)
   frame = getframe;
   writeVideo(writerObj,frame);
end

close(writerObj);