% 2019-2-26 YXC
% extract ED from an list of possible LL (ordered, small-large)
% BST, linear dispersion LL

function [ED,gradient,LL_index,LL_energy] = extract_ED(map,pixx,pixy,varargin)
%rely on the fact that we always see 0 and 1st LL in BST
zero_guess = 140;
allow_deviation = 10;
ED_tolerance = 15;
gradient_guess = 43.5;

if nargin>3
    plott = 0;
    peakss = fit_single_spectrum(map,pixx,pixy,'noplot');
else
    plott = 1;
    peakss = fit_single_spectrum(map,pixx,pixy);
end

if isempty(peakss) == 1
    LL_index = [0,1];
    LL_energy = [0,1];
    ED = 0;
    gradient = 1;
else
    
    [zero_index,move] = matching_index(peakss,zero_guess,ED_tolerance);
    % if zero_index is in fact 0 index, then fit accordingly (0,1,2...LL)
    if move == 0
        % if index only goes up to 0th level
        if length(peakss)<=zero_index 
            zero = peakss(zero_index);
            one = zero+gradient_guess;
        else
            zero = peakss(zero_index);
            one = peakss(zero_index+1);
        end
        grad = one-zero;
        
        %exrtract one negative peak
        minus = zero-grad;
        minus_index = matching_index(peakss,minus);
        minus = peakss(minus_index);
        
        % LL_index = [-1,0,1];
        % LL_energy = [minus,zero,one];
        LL_index = [0,1];
        LL_energy = [zero,one];
        
        peakss(zero_index) = 0;% avoid 1st level replica
        peakss(zero_index+1) = 0;% avoid 1st level replica
        
        for ll = zero_index+2:length(peakss)
            n = ll-zero_index;
            guess = sqrt(n)*grad + zero;
            index = matching_index(peakss,guess);
            if abs(peakss(index)-guess)<allow_deviation
                LL_energy(length(LL_energy)+1)=peakss(index);
                LL_index(length(LL_index)+1)=n;
                peakss(index) = 0; % delete point after assigned to avoid confusion
            end
        end
        
        
    elseif move > 0
        one_index = zero_index;
        if length(peakss)<=one_index
            one = peakss(one_index);
            two = one + (sqrt(2)-1)*gradient_guess;
        else
            one = peakss(one_index);
            two = peakss(one_index+1);
        end
        grad = (two-one)/(sqrt(2)-1);
        

        % LL_index = [-1,0,1];
        % LL_energy = [minus,zero,one];
        LL_index = [1,2];
        LL_energy = [one,two];
        
        peakss(one_index) = 0;% avoid 1st level replica
        peakss(one_index+1) = 0;% avoid 1st level replica
        
        zero = one - grad;
        for ll = one_index+2:length(peakss)
            n = ll-one_index;
            guess = sqrt(n)*grad + zero;
            index = matching_index(peakss,guess);
            if abs(peakss(index)-guess)<allow_deviation
                LL_energy(length(LL_energy)+1)=peakss(index);
                LL_index(length(LL_index)+1)=n;
                peakss(index) = 0; % delete point after assigned to avoid confusion
            end
        end
        
    end
    
    rootn = sign(LL_index).*sqrt(abs(LL_index));
    
    %now we can fit to polynomial
    p = polyfit(rootn,LL_energy,1);
    gradient = p(1);
    xx = [rootn(1)-0.3,rootn(end)+0.3];
    yy = polyval(p,xx);
    ED = p(2);
    
end

if plott == 1
    figure,plot(rootn,LL_energy,'r.', 'MarkerSize',20)
    hold on
    plot(xx,yy,'b')
    xlabel('$$\sqrt{n}$$','Interpreter','latex')
    ylabel('E_n')
    title(['linear fit to LL at (',num2str(pixx),', ',num2str(pixy),')'])
end



end
function [index,move] = matching_index(list,value,varargin)
if nargin<=2
    [~,index] = min(abs(list-value));
    move = 0;
else
    tolerance = varargin{1};
    [expected,index] = min(abs(list-value));
    expected = expected + value;
    if abs(expected-value)>tolerance
        if expected-value>0
            move = +1; % value is index + 1
        else
            move = -1; % value is index -1
        end
    else
        move = 0;
    end
end
end

