function H = rewrite_MKAH(mkahpar)


[nx, ny, nz] = size(mkahpar);

H = zeros(nx, ny+3);
cc =1;
for m = 1:5
    for n=1:10
        for k=1:nx
            
            if mkahpar(k,4) == m
                if mkahpar(k,5) == n
                    H(cc,1:7) = mkahpar(k,:);
                    
                    if mkahpar(k,4) > 5 
                        if mkahpar(k,5) < 6
                            H(cc,8) = ( mkahpar(k,1) - mkahpar(k,2)) - 1;
                            H(cc,9) = ( mkahpar(k,1) + mkahpar(k,2));
                            H(cc,10) = mkahpar(k,3);
                        end
                    else
                            H(cc,8) = ( mkahpar(k,1) - mkahpar(k,2));
                            H(cc,9) = ( mkahpar(k,1) + mkahpar(k,2));
                            H(cc,10) = mkahpar(k,3);
                    end
                    
                    cc = cc+1;
                end
            end
        
        end
    end
end


        

end