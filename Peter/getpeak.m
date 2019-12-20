function p1=getpeak(data,range,sel,r,previous_peak)

loc = peakfinder(data,sel);

p=loc(loc>range(1)&loc<range(2));
if(numel(p)==0)
    p1 = previous_peak;
else
    p1 = p(1);
    N = numel(p);
    if(N>1)
        %p1 = p(1);
        diff = abs(p(1)-previous_peak);
        
        for i=1:N
            curr_diff = abs(p(i)-previous_peak);
            if(curr_diff<diff)
                diff = curr_diff;
                p1 = p(i);
            end
        end
    end
end
% guess = [110000 p 10 0];
% [ynew, o] = fit_to_lorentzian(data',[(p(1)-r) (p(1)+r)],guess);
% c = coeffvalues(o);
% p=c(2);
% figure;
% plot(1:length(data),data,'.k',(p(1)-r):(p(1)+r),ynew,'-r');

end