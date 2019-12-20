%%%%%%%
% CODE DESCRIPTION: Given a phase map of an atomic lattice, the algorithm
%                   finds the center of the atomic locations.  By adjusting
%                   two of the inpurt parameters for a phase shift, other
%                   points may be located (e.g. Ox or Oy atoms instead of
%                   Cu atoms).
%
% INPUT: phase_map - contains phase information in the two orthogonal
%                    directions, phase_map.s_phase1 & phase_map.s_phase2
%        phi_shift1/2 - can offset the  phase from phase_map to find other
%                     atomic locations in between those specified by phase_map
%                     e.g. to get Cu atoms phi_shift1/2 = 0
%                          to get Ox atoms phi_shift1 = pi
%                          to get Ox atoms phi_shift2 = pi
%
% OUTPUT: pos_matrix - a matrix of the same size as phase_map with 1 at
%                      every location where an atom has been located
%
% CODE HISTORY
%
% 131201 MHH  - Created (modified from scripts)
% 07/13/2016 POS - modified
%%%%%%%%

function [pos_matrix, ecall, r1, r2] = atomic_pos_v2(phase_map,phi_shift1,phi_shift2, lfdata)

% topo phase reconstructed from phase_map (for BSCCO, gives Cu positions)
s_phase1 = phase_map.s_phase1 + pi/2 + phi_shift1; s_phase2 = phase_map.s_phase2 + pi/2 + phi_shift2;
% img_plot2(s_phase1); img_plot2(s_phase2);

% topo reconstructed from phase
p_lattice = sin(s_phase1) + sin(s_phase2);
img_plot2(p_lattice);

% shift the phase maps so that they are all positive definite
min_s1 = min(min(s_phase1)); min_s2 = min(min(s_phase2));
offset1 = abs(min_s1 - rem(min_s1,2*pi)) + 2*pi;
offset2 = abs(min_s2 - rem(min_s2,2*pi)) + 2*pi;
s_phase1 = s_phase1 + (offset1);
s_phase2 = s_phase2 + (offset2);



% discretize phase maps to integers - counting number of times phase
% oscillates (corresponds to lines of atomic peaks)
int2 = (s_phase2- rem(s_phase2,2*pi))/(2*pi);
int1 = (s_phase1- rem(s_phase1,2*pi))/(2*pi);
% img_plot2(int1); img_plot2(int2);

int1 = round(int1);
int2 = round(int2);
% img_plot2(int1); img_plot2(int2);

N1 = round(max(max(int1)));
n1 = round(min(min(int1)));
N2 = round(max(max(int2)));
n2 = round(min(min(int2)));


[nr nc] = size(p_lattice);
A = zeros(nr,nc); %records locations of atomic peaks
for i = n1:N1
    for j = n2:N2
        B = (int1 == i) & (int2 == j);
        if (sum(sum(B))) ~= 0
            %mask lattice based on intersections of int1 and int2 (gives
            %neighborhood of each atomic peak)
            pB = p_lattice.*B; 
%             img_plot2(pB);
            % look for grid point where masked lattice is maximum
            C = (pB > 0) &(pB == max(max(pB)));
            if sum(sum(C)) > 1
                % in case there are two points that are maxima, just choose
                % one
                ind = find(C==1,sum(sum(C))-1);
                C(ind) = 0;
            end
            A = A + C;
        end
    end
end
% delete entries around the edges as they tend to be wrong
A(1:2,:) = 0;
A(end-1:end,:) = 0;
A(:,1:2) = 0;
A(:,end-1:end) = 0;
% img_plot2(A)
pos_matrix = A;



%% calculate the real space lattice vectors and convert it to pixels 
q1 = phase_map.q1;
q2 = phase_map.q2;

% conversion number for Angstroem / nm to pixel
pixdim = abs(lfdata.r(2) - lfdata.r(1));

% reciprocal volume
recvol = 2*pi/(q1(1)*q2(2) - q1(2)*q2(1));
r1(1) = recvol * q2(2) / pixdim;
r1(2) = -recvol * q2(1) / pixdim;

r2(1) = -recvol * q1(2) / pixdim;
r2(2) = recvol * q1(1) / pixdim;

% starting point in x and y pixel coordinates
sx = 1 + 0.5 * phi_shift1/pi *r1(1) + 0.5 * phi_shift2/pi *r2(1);
sy = 1 + 0.5 * phi_shift1/pi *r1(2) + 0.5 * phi_shift2/pi *r2(2);

N1 = N1 + 5;
N2 = N2 + 5;

[nx, ny, nz] = size(p_lattice);
cc = 1;


for i = -N1 : N1
    for j = -N2 : N2
        tx = sx + i * r1(1) + j * r2(1);
        ty = sy + i * r1(2) + j * r2(2);
        
        if tx >= 1 && tx <= nx && ty >= 1 && ty <= ny
            ecx(cc) = tx;
            ecy(cc) = ty;
            cc = cc + 1;
        end
        
    end
end

cc = cc - 1;

ecall = [ecx; ecy];

% img_plot2(p_lattice);
% hold on
% for i=1:cc
%             plot(ecx(i), ecy(i),'Color','r','LineWidth',2,'Marker','+','MarkerSize',12);
% end
% hold off
% 
% test = 1;

end