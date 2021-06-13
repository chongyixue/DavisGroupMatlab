%%%%%%%
% CODE DESCRIPTION: Helper function used to generate reference lock-in
% function used in determining the phase map for the given image.
%
% INPUT:  img - the image that is being used to generate periodic reference
%               functions
%         img_r - the coordinate array of the image
%         q_px - location of Bragg peaks in the PSD given in pixel
%                coordinates
%         
% OUTPUT: ref_fun - structure containing the Bragg peak coordinates in the
%                   actual k-space coordinate system, and all 4 reference
%                   sine and cosine functions
%
% CODE HISTORY
%
% 130513 MHH  Cleaned up and made modular to work with phase_map function
% 2020 YXC make it work with subpixel values of q and also 3 ref funs for
% hex system
%%%%%%%%
function ref_fun =  lockin_ref_fun_hex(img,img_r,q_px)

[nr, nc] = size(img);
px_dim = abs(img_r(1)-img_r(2));
k0=2*pi/(nc*px_dim);
if mod(nc,2) == 1
    k=linspace(-k0*nc/2,k0*nc/2,nc);
else
    k = linspace(0,k0*nc/2,nc/2+1);
    k = [-1*k(end:-1:1) k(2:end-1)];    
end

% k0 = pi/(abs(img_r(1) - img_r(2)));
% switch mod(nr,2)
%     case 0
%         k = linspace(0,k0*nc/2,nc/2+1);
%         k = [-1*k(end:-1:1) k(2:end-1)];
%     case 1
%         k=linspace(-k0,k0,nc);
% end

if mod(nr,2) == 0
    q = interpolate_q(k,q_px) - k((nr/2)+1);
%     q = k(q_px) - k((nr/2)+1); % fix k value offsets
else   
    q = interpolate_q(k,q_px);
%     q = k(q_px);
end
[X, Y] = meshgrid(img_r,img_r);

%q_px = (x,y) starting with first quadrant Bragg peak and rotating counter
%clockwise N.B. (x,y) = (col,row);
ref_fun.q1 = q(:,1); ref_fun.q2 = q(:,2);ref_fun.q3 = q(:,3); %1st/2nd quadrant
%ref_fun.q3 = q(:,3); ref_fun.q4 = q(:,4); %3rd/4th quadrant

phase1 = q(1,1)*X + q(2,1)*Y;
phase2 = q(1,2)*X + q(2,2)*Y;
phase3 = q(1,3)*X + q(2,3)*Y;

ref_fun.s_phase1 = phase1;
ref_fun.s_phase2 = phase2;
ref_fun.s_phase3 = phase3;
% lock-in method reference functions
ref_fun.sin1= sin(phase1); ref_fun.cos1 = cos(phase1);
ref_fun.sin2= sin(phase2); ref_fun.cos2 = cos(phase2);
ref_fun.sin3= sin(phase3); ref_fun.cos3 = cos(phase3);

% load_color;
% img_plot2(img,Cmap.Blue2,'IMAGE');
% img_plot2(ref_fun.sin1,Cmap.Blue2,'X-dir sine');img_plot2(ref_fun.cos1,Cmap.Blue2,'X-dir cosine');
% img_plot2(ref_fun.sin2,Cmap.Blue2,'Y-dir sine');img_plot2(ref_fun.cos2,Cmap.Blue2,'Y-dir cosine');

    function q = interpolate_q(k,q_px)
        x = linspace(1,length(k),length(k));
        q = interp1(x,k,q_px);
    end




end