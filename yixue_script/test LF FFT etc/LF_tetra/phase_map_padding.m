% 2020-6-3 YXC

% Bragg(:,i) = ith Bragg pixel.


function phi_map = phase_map_padding(data,Bragg,filt_w)
phi_map.description = 'phi_map generated with padding to remove edge effects';
if isstruct(data)
    nx = size(data.map,1);
else
    nx = size(data,1);
end
% center = ceil((nx+1)/2);
rsigma = nx/(2*pi*filt_w);
points = size(Bragg,2);
phaseshift = cell(points,1);

%% some remnants from previous version
if points == 2
    ref_fun = lockin_ref_fun(data.map,data.r,Bragg);
else
    ref_fun = lockin_ref_fun_hex(data.map,data.r,Bragg);
end
phi_map.q_px = Bragg;

nx2 = min(nx,round(0.7*nx));
nx1 = max(round(nx-nx2),1);
%%

for i=1:points
    istr = num2str(i);
    Qx = Bragg(1,i);
    Qy = Bragg(2,i);
    [phaseshift{i},~,~,~,phase] = gen_phase_map_paper_function(data,Qx,Qy,'padding',1,'sig',rsigma);
    avgshift = min(min(phaseshift{i}.map(nx1:nx2,nx1:nx2)));
    phaseshift{i} = -phaseshift{i}.map+avgshift; % maybe shift phase for a better number
    thetastring = strcat('phi_map.theta',istr,'=phaseshift{i}');
    eval(thetastring);
    
    %% remnant reffuncstring
    reffunstr = strcat('phi_map.q',istr,'=ref_fun.q',istr);
    reffunstr2 = strcat('phi_map.s_phase',istr,'=phase');
    eval(reffunstr);
    eval(reffunstr2);
end

end