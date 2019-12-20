function [Akstruct, Axzkstruct,Ayzkstruct, Axykstruct, jdosstruct,jdosxzstruct,jdosyzstruct,jdosxystruct, jdosxzyzstruct] = fese_jdossim_JEH(eigeps, orbcha)

%% OK, just not viable with a reasonable amount of pixels....

tic

[nx, ny, lambdaz] = size(eigeps);
% define number of pixels used for first Brioullin zone and the kx, ky
n =nx-1;
kxo = linspace(-pi, pi, (n+1));
kyo = linspace(-pi, pi, (n+1));

kx(1:n) = kxo(1:n)-2*pi;
kx(n+1:2*n+1) = kxo;
kx(2*n+2:3*n+1) = kxo(2:n+1)+2*pi;

ky(1:n) = kyo(1:n)-2*pi;
ky(n+1:2*n+1) = kyo;
ky(2*n+2:3*n+1) = kyo(2:n+1)+2*pi;


qx(1:n) = kxo(1:n)-6*pi;
qx(n+1:2*n) = kxo(1:n)-4*pi;
qx(2*n+1:3*n) = kxo(1:n)-2*pi;
qx(3*n+1:4*n+1) = kxo;
qx(4*n+2:5*n+1) = kxo(2:n+1)+2*pi;
qx(5*n+2:6*n+1) = kxo(2:n+1)+4*pi;
qx(6*n+2:7*n+1) = kxo(2:n+1)+6*pi;

qy(1:n) = kyo(1:n)-6*pi;
qy(n+1:2*n) = kyo(1:n)-4*pi;
qy(2*n+1:3*n) = kyo(1:n)-2*pi;
qy(3*n+1:4*n+1) = kyo;
qy(4*n+2:5*n+1) = kyo(2:n+1)+2*pi;
qy(5*n+2:6*n+1) = kyo(2:n+1)+4*pi;
qy(6*n+2:7*n+1) = kyo(2:n+1)+6*pi;

[Yq,Xq]=meshgrid(single(qx),single(qy));

%% find indices for a specific q-value
% qx = k1(1) - k2(1);
% qy = k1(2) - k2(2);
% 
% [rowx, colx] = find(Xq == qx);
% [rowy, coly] = find(Yq == qy);
% 
% qind = [rowx(1),coly(1)];
%% replicate k space and the eigenfunctions correspondingly
kl = length(kx);

for i=1:kl
    for j=1:kl
        kcell{i, j} = [kx(i), ky(j)];
    end
end

kcella = reshape(kcell,kl*kl,1);
epsa = zeros(kl*kl, lambdaz);
kc = kl*kl;

for l = 1:lambdaz
    
    eps(1:kl,1:kl,l) = repmat_jdos(eigeps(:,:,l));
    
%     eps(1:3*nx,1:3*ny,l) = repmat(eigeps(:,:,l),3);
        
    epsa(1:kc, l) = reshape(eps(:,:,l),kc,1);
end

% thermal resolution kB/electron charge units eV and temperature in units
% of Kelvin
tr = 4 * 0.0000861733;
temp = 4.2;

% energy limits and step size
se = -12*0.01;
es = 0.4*0.01;
ee = 12*0.01;

% modulation used for map in eV
dV = 0.004;
%% calculate the jdos as described by J.E. Hoffman, but for the case where 
%% there is more than one e(k) due to the multiple bands

JD = zeros(6*(n+1), 6*(n+1), abs(ee - se)/es+1);

for i=1:kc
    for j=1:kc
        for l=1:lambdaz
            for m=l:lambdaz
                if abs( epsa(i, l) - epsa(j, m) ) < tr * temp;
                    k1 = kcella{i};
                    k2 = kcella{j};
                    px = single(k1(1) - k2(1));
                    py = single(k1(2) - k2(2));
                    
%                     px = round(abs(px/(kx(2)-kx(1)))) * sign(px) * (kx(2)-kx(1));
%                     py = round(abs(py/(ky(2)-ky(1)))) * sign(py) * (ky(2)-ky(1));
                    for n = se : es : ee
                        if abs( n - (epsa(i, l) + epsa(j, m))/2 ) < tr * temp + dV;
                            [rowx, colx] = find(Xq == px);
                            [rowy, coly] = find(Yq == py);
                            i
                            j
                            l
                            m
                            if i==1 && j==2 && l==7 && m==7
                                test=1;
                            end
                            qind = [rowx(1),coly(1)];
                            cc = uint8( abs(se - n)/es+1 );
                            JD(qind(1), qind(2), cc) = JD(qind(1), qind(2), cc)+1;
                        end
                    end
                end
            end
        end
    end
end

cc =1;
for i = -12 :0.4 : 12
    

    % energy en
    en(cc) = i * 0.01;
    
    for l = 1:lambdaz
    % spectral function A(k)
        A(:,:,l) = 1/pi*g ./ ( (en(cc) - eigeps(:,:,l)).^2 + g^2 );
        Axz(:,:,l) = A(:,:,l);
        Ayz(:,:,l) = A(:,:,l);
        Axy(:,:,l) = A(:,:,l);
        
        [row, col] = find( abs(A(:,:,l)) > 0);
        
        for p = 1:length(row)
            sv = orbcha{row(p), col(p), l};
            Axz(row(p), col(p), l) = A(row(p), col(p),l)*sv(1);
            Ayz(row(p), col(p), l) = A(row(p), col(p),l)*sv(3);
            Axy(row(p), col(p), l) = A(row(p), col(p),l)*sv(2);
        end
        test = 1;
%         figure, imagesc(A(:,:,l))
    end
    Awk(:,:,cc) = sum(A,3);
    Awkxz(:,:,cc) = sum(Axz,3);
    Awkyz(:,:,cc) = sum(Ayz,3);
    Awkxy(:,:,cc) = sum(Axy,3);
    

    JD = xcorr2(Aall(:,:,i));
    JDxz = xcorr2(Axzp(:,:,i));
    JDyz = xcorr2(Ayzp(:,:,i));
    JDxy = xcorr2(Axyp(:,:,i));
    




jdosstruct.map = JDC;
jdosstruct.type = 0;
jdosstruct.ave = [];
jdosstruct.name = 'Joint density of states';
jdosstruct.r = qx;
jdosstruct.coord_type = 'r';
jdosstruct.e = en;
jdosstruct.ops = '';
jdosstruct.var = 'JDOS (q,E)';

jdosxzstruct = jdosstruct;
jdosxzstruct.map = JDCxz;
jdosxzstruct.var = 'JDOS xz (q,E)';

jdosyzstruct = jdosstruct;
jdosyzstruct.map = JDCyz;
jdosyzstruct.var = 'JDOS yz (q,E)';

% jdosxystruct = jdosstruct;
% jdosxystruct.map = JDCxy;
% jdosxystruct.var = 'JDOS xy (q,E)';
% 
% jdosxzyzstruct = jdosstruct;
% jdosxzyzstruct.map = JDCxzyz;
% jdosxzyzstruct.var = 'JDOS xz <-> yz (q,E)';

test=1;

toc
end