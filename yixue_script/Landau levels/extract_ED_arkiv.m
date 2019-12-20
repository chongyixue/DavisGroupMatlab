% 2019-2-26 YXC
% extract ED from an list of possible LL (ordered, small-large)
% BST, linear dispersion LL

function [ED,gradient,LL_index,LL_energy] = extract_ED_arkiv(map,pixx,pixy,varargin)
%rely on the fact that we always see 0 and 1st LL in BST
zero_guess = 140;
allow_deviation = 10;

if nargin>3
    plott = 0;
    peaks = fit_single_spectrum(map,pixx,pixy,'noplot');
else
    plott = 1;
    peaks = fit_single_spectrum(map,pixx,pixy);
end

zero_index = matching_index(peaks,zero_guess);
zero = peaks(zero_index);
one = peaks(zero_index+1);
grad = one-zero;

%exrtract one negative peak
minus = zero-grad;
minus_index = matching_index(peaks,minus);
minus = peaks(minus_index);

% LL_index = [-1,0,1];
% LL_energy = [minus,zero,one];    
LL_index = [0,1];
LL_energy = [zero,one];

peaks(zero_index) = 0;% avoid 1st level replica
peaks(zero_index+1) = 0;% avoid 1st level replica

for ll = zero_index+2:length(peaks)
    n = ll-zero_index;
    guess = sqrt(n)*grad + zero;
    index = matching_index(peaks,guess);
    if abs(peaks(index)-guess)<allow_deviation
        LL_energy(length(LL_energy)+1)=peaks(index);
        LL_index(length(LL_index)+1)=n;
        peaks(index) = 0; % delete point after assigned to avoid confusion
    end
end

rootn = sign(LL_index).*sqrt(abs(LL_index));
%now we can fit to polynomial
p = polyfit(rootn,LL_energy,1);
gradient = p(1);
xx = [rootn(1)-0.3,rootn(end)+0.3];
yy = polyval(p,xx);
ED = p(2);

if plott == 1
    figure,plot(rootn,LL_energy,'r.', 'MarkerSize',20)
    hold on
    plot(xx,yy,'b')
    xlabel('$$\sqrt{n}$$','Interpreter','latex')
    ylabel('E_n')
    title(['linear fit to LL at (',num2str(pixx),', ',num2str(pixy),')'])
end



end
function index = matching_index(list,value)
[~,index] = min(abs(list-value));
end


