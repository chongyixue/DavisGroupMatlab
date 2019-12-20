function ref_fun =  lockin_ref_fun(img,img_r,q_px)

[nr, nc] = size(img);
px_dim = abs(img_r(1) -img_r(2));
%k0=2*pi/(max(img_r)-min(img_r));
%k=linspace(-k0*nc/2,k0*nc/2,nc);
k0=2*pi/(nc*px_dim);
nc
if mod(nc,2)
    k=linspace(-k0*nc/2,k0*nc/2,nc);
else
    k = linspace(0,k0*nc/2,nc/2+1);
    k = [-1*k(end:-1:1) k(2:end-1)];
    %k = [-1*k(end-1:-1:2) k]
end
%ft_img = fourier_transform2d(img,'none','complex','ft');
%img_plot2(abs(ft_img));
if mod(nr,2) == 0
    q = k(q_px) - k((nr/2)+1); % fix k value offsets
else
    %q = k(q_px) - k((nr/2+1));
    q = k(q_px);
end

[X, Y] = meshgrid(img_r,img_r);

%q_px = (x,y) starting with first quadrant Bragg peak and rotating counter
%clockwise N.B. (x,y) = (col,row);
ref_fun.q1 = q(:,1); ref_fun.q2 = q(:,2); %1st/2nd quadrant
ref_fun.q3 = q(:,3); ref_fun.q4 = q(:,4); %3rd/4th quadrant

% lock-in method reference functions
ref_fun.sin1= sin(q(2,1)*X + q(1,1)*Y); ref_fun.cos1 = cos(q(2,1)*X + q(1,1)*Y);
ref_fun.sin2= sin(q(2,2)*X + q(1,2)*Y); ref_fun.cos2 = cos(q(2,2)*X + q(1,2)*Y);

%load_color;
% img_plot2(img,Cmap.Blue2,'IMAGE');
% img_plot2(ref_fun.sin1,Cmap.Blue2,'X-dir sine');img_plot2(ref_fun.cos1,Cmap.Blue2,'X-dir cosine');
% img_plot2(ref_fun.sin2,Cmap.Blue2,'Y-dir sine');img_plot2(ref_fun.cos2,Cmap.Blue2,'Y-dir cosine');
end