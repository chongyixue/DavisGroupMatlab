function k = r_to_k_coord(r)
k0 = pi/(abs(r(1) - r(2)));
nr = length(r);
    switch mod(nr,2)
        case 0
%             k = linspace(0,k0,nr/2+1);
%             k = [-1*k(end:-1:1) k(2:end-1)]; 
            
            % use this when you have symmetrized the data
            k = linspace(0,k0,nr/2);
            k = [-1*k(end:-1:1) k(1:end)]; 
            
            
        case 1
            k=linspace(-k0,k0,nr);
    end
end