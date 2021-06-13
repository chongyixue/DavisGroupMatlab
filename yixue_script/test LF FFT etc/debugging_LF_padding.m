% 2021/5/27 YXC


% load tetratopo.mat
% newmap = LF_phase_gen_dialogue(topo);vs
% newmap = LF_phase_gen_dialogue_tetra_padding(topo);

q1 = [53,81];
q2 = [81,25];
newmap = LF_phase_gen_dialogue(topo,[q1',q2']);

newmap = LF_phase_gen_dialogue_tetra_padding(topo,[q1',q2']);



