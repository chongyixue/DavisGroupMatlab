% 2019-12-18 YXC
% iterative step in getting the P(E) function, just the P(0) part
% P0(E) = I(E)+int(dw)K(E,w)P0(E-hbar w)

function [P,omega] = P0_function(alpha,omega0,CJ,mK)
CJ = abs(CJ);
alpha = abs(alpha);
omega0 = abs(omega0);
%% some predefined variables
beta = 1/(2.585*10^-5); %eV-1
beta = beta*300/mK;
hbar = 6.5821196*10^(-16); %eV*s
%note let's make all omega == hbar*omega
RQ = 6.626*10^(-34)/(2*(1.602177*10^(-19))^2);
D = (pi/beta).*real(total_imp(0))/RQ;
omegamax = 10^(-3);
% omegamax = 10^(-2);
dw = 10^(-6);
% dw = 10^(-4);
% dw = omegamax/1000;

% dw = 0.00001;
if omegamax/dw~=round(omegamax/dw) %make sure there is an odd number of dots
    omegamax = round(omegamax/dw)*dw;
end
divs = omegamax*2/dw+1;
omega = linspace(-omegamax,omegamax,divs);
omega = reshape(omega,1,length(omega));

energy_eV_list = omega; % make energy E and omega have same points and divs

%% core loop to get convergence for P0 
% somehow i think only I matters
I = inhomogeneity(energy_eV_list);
I = reshape(I,1,length(I));

K = largeK(energy_eV_list,omega);
% Kgauge = sum(sum(isnan(K)))
% Igauge = sum(isnan(I))

P0 = I;
% P0 = 1000*ones(size(P0));
% figure,plot(I)

% figure,

for kk = 1:7
    Pnew = P0step(P0);
%     Pnew = P0step_convolution(P0);
    diff = sum(Pnew-P0);
    P0 = Pnew;
%     plot(Pnew)
%     hold on
end
% figure,plot(P0)
%% diagnosis
% figure,plot(omega,real(total_imp(omega)),'b')
% hold on
% plot(omega,imag(total_imp(omega)),'b--')
% omega0 = 2*omega0;
% figure,plot(omega,real(total_imp(omega)),'r')
% hold on
% plot(omega,imag(total_imp(omega)),'r--')

% figure,plot(omega,(largeK(omega,0)),'b')
% hold on
% 
% omega0 = 2*omega0;
% plot(omega,(largeK(omega,0)),'r')


%% calculation for PN
EC = 2*1.6*10^(-19)/CJ; %eV
SQ = sqrt(beta/(4*pi*EC));
PN = SQ*exp(-(beta.*energy_eV_list.^2)./(4*EC));
% figure,plot(omega,PN)
% title("PN")
P = conv(P0,PN,'same')*dw;
% figure,plot(omega,PN)
% title("P(E)")
% P = P0;

%% functions
    function P0 = P0step_convolution(P0previous)
        P0past = reshape(P0previous,length(P0previous),1);
        P0 = zeros(length(P0past),length(omega));
        P0 = conv(P0,P0previous,'same');
    end
        

    function P0 = P0step(P0previous)
        P0past = reshape(P0previous,length(P0previous),1);

        P0 = zeros(length(P0past),length(omega));
        
%         energy_eV = omega; %make it a square matrix for simpler numerics
        pix = length(omega); %odd number
        mid = (pix+1)/2;
        for i=1:pix
            if i<=mid
                start_j=1;
                endd_j =pix-(mid-i);
                head = 0;
            else
                start_j=i-mid+1;
                endd_j = pix;
                head = 1;
            end
            interval = round(endd_j-start_j+1);
            
            if head == 0
                P0(start_j:endd_j,i)=P0past(end-interval+1:end);
            else
                P0(start_j:endd_j,i)=P0past(1:interval);
            end
        end
            
        % now P0 is 2D, P0(E_index,w_index)
        P0 = K.*P0;
        P0 = sum(P0,2)*dw;
        
        P0 = reshape(P0,1,length(P0));
%         figure,plot(P0,'b')
%         hold on
        
        P0 = I + P0;
%         plot(P0,'r')
%         figure,plot(P0);title(strcat("step ",num2str(kk)))
    end


    function I = inhomogeneity(energy_eV)
       I = (1/pi).*D./(D.^2+energy_eV.^2); 
    end

    function K = largeK(energy_eV,omegalist)%pay attention to the resulting indexing
        E = reshape(energy_eV,length(energy_eV),1); %E is the first index
        omeg = reshape(omegalist,length(omegalist),1);
        omeg = omeg'; %omega is the second index
        k = small_k(omeg);
        Kapp = Kappa(omeg);
        Kapp = reshape(Kapp,1,length(Kapp)); %make Kapp(w)...
        k = reshape(k,1,length(omeg)); % make k(w) same dimension index as omega
%         fraction = hbar./(D.^2+E.^2);
        fraction = 1./(D.^2+E.^2);
%         isnan(k)
        K = E.*fraction.*k+fraction.*D.*Kapp;
%         isnan(K)
    end

    function k = small_k(omegalist)
        secondpart = (1./(beta.*omegalist.*RQ)).*real(total_imp(0));
        firstpart = (1./(1-exp(-beta.*omegalist))).*(real(total_imp(omegalist))./RQ);
%         isnan(secondpart)
        k = firstpart - secondpart;
        k(isnan(k))=0;
        mid = (length(omegalist)+1)/2;
        k(mid) = 0.5*(k(mid-1)+k(mid+1));
    end

    function Kapp = Kappa(omegalist)
        infinity = 10^2;
        summatsubara = 0;
        for i=1:infinity
            nv = Matsubara(i);
            summatsubara = summatsubara + (nv./(nv^2+omegalist.^2)).*total_imp(-1i*nv);
        end
        
%         beta
%         200*pi/beta
%         figure,plot(1:infinity,Matsubara(1:infinity))
%         title("matsubara")
        secondpart = summatsubara.*2/(beta*RQ);
        firstpart = (1./(1-exp(-beta.*omegalist))).*(imag(total_imp(omegalist))./RQ);
        %lopital's rule when omega->0 firstpart = 0?
        nan = isnan(firstpart);
        firstpart(nan) = 0.5/RQ;
        Kapp = firstpart-secondpart;
        mid = (length(omegalist)+1)/2;
        Kapp(mid)=(Kapp(mid-1)+Kapp(mid+1))/2;
    end

    function nv = Matsubara(n) %in units of eV
       nv = hbar*2*n*pi/(hbar*beta); 
    end

    function Z = impedance(omegalist)
        R_env = 376.73; %Ohms
        tangent = tan(pi.*omegalist/(2*omega0));
        numerator = 1+1i.*tangent/alpha;
        denom = 1+1i*alpha.*tangent;
        Z = R_env.*numerator./denom;
    end
    
    function ZT = total_imp(omegalist)%omega in units of eV, so omega=hbar*w
        Z = impedance(omegalist);
        inverseZ = 1./Z;
        ZT = 1./(1i*omegalist.*CJ./hbar+inverseZ);
    end

end
