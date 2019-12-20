function [M N] = dos_hf

k_res = 0.00005;
k_st = 0;
k_end = 1;

count = 1;

E_tol = 0.1;
E1 = low_band(k_st,0);
E2 = low_band(k_st + k_res,0);

index = 1;
while k_st <= k_end    
    N(index,1) = E1;
    while(abs(E1 - E2) < E_tol)
        count = count + 1;
        E2 = low_band(k_st + count*k_res,0);
    end
    N(index,2) = count;
    E1 = E2;
    k_st = k_st + count*k_res;
    count = 0;
    index = index + 1;
end
figure; plot(N(:,2),N(:,1),'x')


count = 1;
%k_res = 0.0001;
k_st = 0.8;
k_end = 3;
%E_tol = 0.0001;
E1 = high_band(k_st,0);
E2 = high_band(k_st + k_res,0);

index = 1;
while k_st <= k_end    
    M(index,1) = E1;
    while(abs(E1 - E2) < E_tol)
        count = count + 1;
        E2 = high_band(k_st + count*k_res,0);
    end
    M(index,2) = count;
    E1 = E2;
    k_st = k_st + count*k_res;
    count = 0;
    index = index + 1;
end
figure; plot(M(:,2),M(:,1),'rx')



end