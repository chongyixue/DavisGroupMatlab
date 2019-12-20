

obj_allsim_JDOS.cpx_map = obj_allsim_JDOS.map;

[nx, ny, nz] = size(obj_allsim_JDOS.map);

obj_allsim_JDOS_rspace = fourier_transform2d(  obj_allsim_JDOS  ,'none','real','ift');

% 
for k = 1 : nz
    obj_allsim_JDOS_rspace.map(:,:,k) = ifftshift( obj_allsim_JDOS_rspace.map(:,:,k)  );
end

% crop, interpolate, rotate, and interpolate in order to align defect
% 60801A00 and the simulation to each other
obj_allsim_JDOS_rspace.map = obj_allsim_JDOS_rspace.map(150:228, 150:228, :);
obj_allsim_JDOS_rspace.r = obj_allsim_JDOS_rspace.r(1: (228-150)+1);


obj_allsim_JDOS_rspace_int = pix_dim(obj_allsim_JDOS_rspace,401);

img = obj_allsim_JDOS_rspace_int.map;
obj_allsim_JDOS_rspace_int_rot = obj_allsim_JDOS_rspace_int;
obj_allsim_JDOS_rspace_int_rot.map = imrotate(img,45,'crop');    

obj_allsim_JDOS_rspace_int_rot.map = obj_allsim_JDOS_rspace_int_rot.map(150:252, 150:252, :);
obj_allsim_JDOS_rspace_int_rot.r = obj_allsim_JDOS_rspace_int_rot.r(1: (252-150)+1);

obj_allsim_JDOS_rspace_int_rot_int = pix_dim(obj_allsim_JDOS_rspace_int_rot,128);