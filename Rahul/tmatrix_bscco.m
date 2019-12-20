function [out1,out2] = tmatrix_bscco(n_q,E,n_E)
%INPUT: k points in units of 1/a, n_k has to be odd
%E in eV, E runs from -E to +E for n_E points, n_E has to be odd
tic
[qx,qy] = meshgrid(linspace(-1,1,n_q));
Epoints = linspace(-E,E,n_E);%converting in eV
I = eye(2);
Vs = 0.1;
Vm = 0.0;

% calculate TB model energies as per Wang and Lee QPI PRB, who used Norman
t1 = 0.1305; 
t2 = -0.5951;
t3 = 0.1636;
t4 = -0.0519;
t5 = -0.1117;
t6 = 0.0510;
E_tb = t1 + t2*(cos(pi*qx)+cos(pi*qy))/2 + t3*cos(pi*qx).*cos(pi*qy) + t4*(cos(2*pi*qx)+cos(2*pi*qy))/2 ...
         +t5*(cos(2*pi*qx).*cos(pi*qy)+cos(pi*qx).*cos(2*pi*qy))/2 + t6*cos(2*pi*qx).*cos(2*pi*qy);


% calculate gap function
D0 = 0.0;
D = D0*(cos(pi*qx)-cos(pi*qy));%+1i*D0/4)/sqrt(1^2+(1/4)^2);

%calculate Green's function (2x2 matrix) for each k and E value
G11 = zeros(n_q,n_q,n_E);
G12 = zeros(n_q,n_q,n_E);
G21 = zeros(n_q,n_q,n_E);
G22 = zeros(n_q,n_q,n_E);
G11r = zeros(n_q,n_q,n_E);
G12r = zeros(n_q,n_q,n_E);
G22r= zeros(n_q,n_q,n_E);
G21r = zeros(n_q,n_q,n_E);
d=0.0015;
for k=1:n_E
    den = (Epoints(k)^2-E_tb.^2-D.^2-d^2+1i*2*Epoints(k)*d);
    G11(:,:,k) = (Epoints(k) + E_tb + 1i*d) ./den;
    G22(:,:,k) = (Epoints(k) - E_tb + 1i*d) ./den;
    G12(:,:,k) = D./den;
    G21(:,:,k) = G12(:,:,k);
    %get all G's in r-space for useful computations later
    G11r(:,:,k) = fftshift(fft2(G11(:,:,k)));
    G12r(:,:,k) = fftshift(fft2(G12(:,:,k)));
    G21r(:,:,k) = fftshift(fft2(G21(:,:,k)));
    G22r(:,:,k) = fftshift(fft2(G22(:,:,k)));
end

toc

%calculate T matrix
T11 = zeros(1,n_E);
T12 = zeros(1,n_E);
T21 = zeros(1,n_E);
T22 = zeros(1,n_E);
sumG_ind = (n_q+1)/2;
for k=1:n_E
    A = [Vs+Vm, 0.0;...
           0.0, -Vs+Vm];
    B = [G11r(sumG_ind,sumG_ind,k),G12r(sumG_ind,sumG_ind,k);...
        G21r(sumG_ind,sumG_ind,k),G22r(sumG_ind,sumG_ind,k)];
    C = I - A*B;
    T = A/C;
    T11(k) = T(1,1);       
    T12(k) = T(1,2);
    T21(k) = T(2,1);
    T22(k) = T(2,2);    
end
toc

%calculate A
A11r = zeros(n_q,n_q,n_E);
A22r = zeros(n_q,n_q,n_E);
for k=1:n_E
    for i=1:n_q
        for j=1:n_q
            A11r(i,j,k) = G11r(i,j,k)*T11(k)*G11r(n_q-i+1,n_q-j+1,k)...
                        + G11r(i,j,k)*T12(k)*G21r(n_q-i+1,n_q-j+1,k)...
                        + G12r(i,j,k)*T21(k)*G11r(n_q-i+1,n_q-j+1,k)...
                        + G12r(i,j,k)*T22(k)*G21r(n_q-i+1,n_q-j+1,k);
            
            A22r(i,j,k) = G21r(i,j,k)*T11(k)*G12r(n_q-i+1,n_q-j+1,k)... 
                        + G21r(i,j,k)*T12(k)*G22r(n_q-i+1,n_q-j+1,k)...
                        + G22r(i,j,k)*T21(k)*G12r(n_q-i+1,n_q-j+1,k)... 
                        + G22r(i,j,k)*T22(k)*G22r(n_q-i+1,n_q-j+1,k);
        end
    end
end
toc


%calculate dn, change in density of states
dnr = zeros(n_q,n_q,n_E);
for k=1:n_E  
    dnr(:,:,k) = -imag(A11r(:,:,k)+A22r(:,:,n_E-k+1))/pi/2 ;
end
out1 = -imag(G11);
mat2STM_Viewer(out1,-E,E,n_E)
out2 = dnr;
mat2STM_Viewer(out2,-E,E,n_E)
toc