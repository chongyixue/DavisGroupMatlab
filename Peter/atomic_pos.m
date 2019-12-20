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
%%%%%%%%

function pos_matrix = atomic_pos(phase_map,phi_shift1,phi_shift2)

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
end