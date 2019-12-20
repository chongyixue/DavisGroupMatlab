function H = Hirschfeld_tb_hamiltonian_MKAH(px, py, p1, p2, kz,mkahpar)

H = zeros(10,10,1);


[nx, ny, nz] = size(mkahpar);
for k=1:nx
    H(mkahpar(k,4), mkahpar(k,5),1) = H(mkahpar(k,4), mkahpar(k,5),1) +...
        mkahpar(k,6) * exp( 1i * (p1 * mkahpar(k,1) + p2 * mkahpar(k,2) +...
        kz * mkahpar(k,3) ) );
    if mkahpar(k,4) > 5 
        if mkahpar(k,5) < 6
            H(mkahpar(k,4), mkahpar(k,5),1) = exp(-1i * px) * ...
                H(mkahpar(k,4), mkahpar(k,5),1);
        end
    end
%     if mkahpar(k,4) < 6 
%         if mkahpar(k,5) > 5
%             H(mkahpar(k,4), mkahpar(k,5),1) = exp(-1i * px) * ...
%                 H(mkahpar(k,4), mkahpar(k,5),1);
%         end
%     end
end
% 

H(6:10, 1:5, 1) = conj(H(1:5,6:10,1));
H(6:10, 6:10, 1) = conj(H(1:5,1:5,1));
        

end