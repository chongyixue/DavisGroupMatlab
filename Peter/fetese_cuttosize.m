function comap = fetese_cuttosize(map,col,cot,cob,cor)

% comap = map(1+col:end-cor,1+cot:end-cob,:);

comap = map(1+cot:end-cob,1+col:end-cor,:);


end