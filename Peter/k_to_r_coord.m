function r = k_to_r_coord(k)
nk = length(k);
r0 = pi/max(abs(k))*(nk-1);
r = linspace(0, r0,nk);
%     switch mod(nk,2)
%         case 0
%             r = linspace(0,k0,nr/2+1);
%             r = [-1*k(end:-1:1) k(2:end-1)]; 
%             
%         case 1
%             r = linspace(-k0,k0,nr);
%     end
end