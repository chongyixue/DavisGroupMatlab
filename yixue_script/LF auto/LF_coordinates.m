%%%%%%%
% CODE DESCRIPTION: generates a final set of shifted coordinate to be used
% by LF_correct_map to fix maps.  Can specify the number of iterations of
% phase correct to be performed.  Assumes that each subsequent phase after
% the first does not have phase slips (i.e. does not need
% phase_slip_correct_dialogue function).
%
% INPUT:  itr - number of iterations of phase correction
%         phase - first phase slip correct phase map
%         data - usually the topo (1 layer) from which successive phase maps will be
%                generated to give the final set of shifted coordinates
%         varargin - if the data is not a structure then varargin should
%                    contain the coordinates of image contained in the data variable
%
% OUTPUT: topo_f_x/y - contain the final set of adjusted coordinates used by
%                      LF_correct to adjust other maps
%
% CODE HISTORY
%
% 130514 MHH  - Created
%%%%%%%%
function [topo_f_x topo_f_y, strain_map] = LF_coordinates(itr,filt_width,phase_cor,data,varargin)
%use the phase slip adjusted phase map for the first iteration
phase = phase_cor;
q_px = phase_cor.q_px;
if isstruct(data)
    map = data.map;    
    img_r = data.r;    
else
    map = data;
    img_r = varargin{1}; %if the input is not a structure, then the user also input the coordinate of the image
end
[nr nc nz] = size(map);
[X Y] = meshgrid(img_r,img_r);

q1 = phase.q1; q2 = phase.q2;
Q = [q1(1,1) q1(2,1); q2(1,1) q2(2,1)];
Inv_Q = inv(Q); % see Hamidian et al. NJP (2011) for details

strain_map = zeros(nr, nc, 18);
for i = 1:itr
    i
    % apply affine transformation to each pixel coordinate to fix phase errors
    ux_corr = Inv_Q(1,1).*(phase.theta1+pi/2) + Inv_Q(1,2).*(phase.theta2+pi/2);
    uy_corr = Inv_Q(2,1).*(phase.theta1+pi/2) + Inv_Q(2,2).*(phase.theta2+pi/2);
    
    strain_map(:,:,1) = ux_corr;
    strain_map(:,:,2) = uy_corr;
    % compute strain after M.J. Hytch et al., Ultramicroscopy 74 (1998)
    % 131-146
    
    % this method avoids having to worry about the phase-slips
    [s_1x, s_1y] = gradient( exp(1i*phase.theta1) );
    [s_2x, s_2y] = gradient( exp(1i*phase.theta2) );
    
    dx_th1 = imag( exp(-1i*phase.theta1) .* s_1x );
    dy_th1 = imag( exp(-1i*phase.theta1) .* s_1y );
    
    dx_th2 = imag( exp(-1i*phase.theta2) .* s_2x );
    dy_th2 = imag( exp(-1i*phase.theta2) .* s_2y );
    
    e_xx = -1/(2*pi) * ( Inv_Q(1,1).* dx_th1 + Inv_Q(1,2).* dx_th2 );
    e_xy = -1/(2*pi) * ( Inv_Q(1,1).* dy_th1 + Inv_Q(1,2).* dy_th2 );
    e_yx = -1/(2*pi) * ( Inv_Q(2,1).* dx_th1 + Inv_Q(2,2).* dx_th2 );
    e_yy = -1/(2*pi) * ( Inv_Q(2,1).* dy_th1 + Inv_Q(2,2).* dy_th2 );
    
    % save strain (symmetric part) in strain map
    strain_map(:,:,3) = 1/2*(e_xx + e_xx);
    strain_map(:,:,4) = 1/2*(e_xy + e_yx);
    strain_map(:,:,5) = 1/2*(e_yx + e_xy);
    strain_map(:,:,6) = 1/2*(e_yy + e_yy);
    % save rotation (antisymmetric part in strain map)
    strain_map(:,:,8) = 1/2*(e_xy - e_yx);
    strain_map(:,:,9) = 1/2*(e_yx - e_xy);
    
    
    % plot the results - for test purposes
%     figure,
%     subplot(3,2,1), imagesc(ux_corr), title('Displacement u_x'),  shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,3), imagesc(e_xx), title('Strain \epsilon_{xx}'), shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,5), imagesc(e_xy), title('Strain \epsilon_{xy}'), shading flat; axis off; colormap('gray'), axis equal
%     
%     subplot(3,2,2), imagesc(uy_corr), title('Displacement u_y'),  shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,4), imagesc(e_yx), title('Strain \epsilon_{yx}'), shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,6), imagesc(e_yy), title('Strain \epsilon_{yy}'), shading flat; axis off; colormap('gray'), axis equal
%     
    % just the gradient - will diverge where there are phase slips
    [g_xx, g_xy] = gradient( ux_corr );
    [g_yx, g_yy] = gradient( uy_corr );
    
    strain_map(:,:,11) = -1/2*(g_xx + g_xx);
    strain_map(:,:,12) = -1/2*(g_xy + g_yx);
    strain_map(:,:,13) = -1/2*(g_yx + g_xy);
    strain_map(:,:,14) = -1/2*(g_yy + g_yy);
    
    % save rotation (antisymmetric part in strain map)
    strain_map(:,:,16) = -1/2*(g_xy - g_yx);
    strain_map(:,:,17) = -1/2*(g_yx - g_xy);
    
    
    % plot the results
%     figure,
%     subplot(3,2,1), imagesc(ux_corr), title('Displacement u_x'),  shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,3), imagesc(-g_xx), title('Strain \epsilon_{xx}'), shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,5), imagesc(-g_xy), title('Strain \epsilon_{xy}'), shading flat; axis off; colormap('gray'), axis equal
%     
%     subplot(3,2,2), imagesc(uy_corr), title('Displacement u_y'),  shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,4), imagesc(-g_yx), title('Strain \epsilon_{yx}'), shading flat; axis off; colormap('gray'), axis equal
%     subplot(3,2,6), imagesc(-g_yy), title('Strain \epsilon_{yy}'), shading flat; axis off; colormap('gray'), axis equal
    
    % determine shifts in coordinates from  phase correction
    topo_f_x = X + ux_corr;
    topo_f_y = Y + uy_corr;
    
    %apply correction to topo
    img_correct = [];
    img_correct = griddata(topo_f_x,topo_f_y,map,X,Y,'linear');
    A = isnan(img_correct);
    img_correct(A) = 0;
    map = img_correct;  
    
    %recalcaulate the phase map based on the last corrected map
    phase = phase_map(map,img_r,q_px,filt_width);
    % update coordinates for image for next iteration
    X = topo_f_x; Y = topo_f_y;
end
end