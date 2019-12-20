function s = fix_spect(input_spect)
s = input_spect;
s = rmfield(s,'bkwd');
s = rmfield(s,'fwd');
s.energy = [-input_spect.energy; input_spect.energy(end:-1:1)];
s.spect = [input_spect.bkwd(end:-1:1) ; input_spect.fwd(end:-1:1)];
figure; plot(s.energy,s.spect);
end