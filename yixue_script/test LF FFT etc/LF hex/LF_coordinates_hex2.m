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
function [topo_f_x topo_f_y] = LF_coordinates_hex(itr,filt_width,phase_cor,data,varargin)
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

q1 = phase.q1; q2 = phase.q2; q3 = phase.q3;
Q = [q1(1,1) q1(2,1); q2(1,1) q2(2,1); q3(1,1) q3(2,1)];
Inv_Q = pinv(Q); %non-square matrix inverse
% Q = [q1(1,1) q1(2,1) 1; q2(1,1) q2(2,1) 1; q3(1,1) q3(2,1) 1];
% Inv_Q = inv(Q); % see Hamidian et al. NJP (2011) for details

% Inv_Q
% Inv_Q*Q
% Q*Inv_Q

for i = 1:itr
%     i
    % apply affine transformation to each pixel coordinate to fix phase errors
%     ux_corr = Inv_Q(1,1).*(phase.theta1+pi/2) + Inv_Q(1,2).*(phase.theta2+pi/2) + Inv_Q(1,3).*(phase.theta3+pi/2);
%     uy_corr = Inv_Q(2,1).*(phase.theta1+pi/2) + Inv_Q(2,2).*(phase.theta2+pi/2) + Inv_Q(2,3).*(phase.theta3+pi/2);
    addphase = pi/2;
    ux_corr = Inv_Q(1,1).*(phase.theta1+addphase) + Inv_Q(1,2).*(phase.theta2+addphase) + Inv_Q(1,3).*(phase.theta3+addphase);
    uy_corr = Inv_Q(2,1).*(phase.theta1+addphase) + Inv_Q(2,2).*(phase.theta2+addphase) + Inv_Q(2,3).*(phase.theta3+addphase);

    
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