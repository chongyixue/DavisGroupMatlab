function FeSe_soc_check

% orbital eigenvectors
% z^2
evec{1} = [1, 0, 0, 0, 0];
evec{2} = [1, 0, 0, 0, 0];
% xz
evec{3} = [0, 1, 0, 0, 0];
evec{4} = [0, 1, 0, 0, 0];
% yz
evec{5} = [0, 0, 1, 0, 0];
evec{6} = [0, 0, 1, 0, 0];
% x^2-y^2
evec{7} = [0, 0, 0, 1, 0];
evec{8} = [0, 0, 0, 1, 0];
% xy
evec{9} = [0, 0, 0, 0, 1];
evec{10} = [0, 0, 0, 0, 1];
% angular momentum matrices

lx = [0, 0, sqrt(3)*1i, 0, 0;...
    0, 0, 0, 0, 1i;...
    -sqrt(3)*1i, 0, 0, -1i, 0;...
    0, 0, 1i, 0, 0;....
    0, -1i, 0, 0, 0];

ly = [0, sqrt(3)*1i, 0, 0, 0;...
    -sqrt(3)*1i, 0, 0, 1i, 0;...
    0, 0, 0, 0, 1i;...
    0, -1i, 0, 0, 0;...
    0, 0, -1i, 0, 0];

lz = [0, 0, 0, 0, 0;...
    0, 0, -1i, 0, 0;...
    0, 1i, 0, 0, 0;...
    0, 0, 0, 0, -2*1i;...
    0, 0, 0, 2*1i, 0];




% spin functions
% up
sup = [1, 0];
% down
sdown = [0, 1];

% Spin matrices
sx = 1/2*[0, 1; 1, 0];
sy = 1/2*[0, -1i; 1i, 0];
sz = 1/2*[1, 0; 0, -1];

HSO = zeros(10,10);

for k=1:10
    for l=1:10
        if mod(k,2) == 0
            if mod(l,2) == 0
                HSO(k,l) = (sdown*sx*sdown') * (evec{k}*lx*evec{l}') + ...
                    (sdown*sy*sdown') * (evec{k}*ly*evec{l}')+...
                    (sdown*sz*sdown') * (evec{k}*lz*evec{l}');
            else
                HSO(k,l) =  (sdown*sx*sup') * (evec{k}*lx*evec{l}') + ...
                    (sdown*sy*sup') * (evec{k}*ly*evec{l}')+...
                    (sdown*sz*sup') * (evec{k}*lz*evec{l}') ;
            end
        else
            if mod(l,2) == 0
                HSO(k,l) =  (sup*sx*sdown') * (evec{k}*lx*evec{l}') + ...
                    (sup*sy*sdown') * (evec{k}*ly*evec{l}')+...
                    (sup*sz*sdown') * (evec{k}*lz*evec{l}') ;
            else
                HSO(k,l) =  (sup*sx*sup') * (evec{k}*lx*evec{l}') + ...
                    (sup*sy*sup') * (evec{k}*ly*evec{l}')+...
                    (sup*sz*sup') * (evec{k}*lz*evec{l}') ;
            end
        end
    end
end

test =1;
end
