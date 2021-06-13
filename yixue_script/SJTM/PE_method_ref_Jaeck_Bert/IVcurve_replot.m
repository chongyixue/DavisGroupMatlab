% 2019-12-19 YXC
% interpolate the points of IV curve from required V list.

function I = IVcurve_replot(V_list,alpha,omega0,CJ,EJ,mK)

[V0,I0] = IVcurve(alpha,omega0,CJ,EJ,mK);
if sum(isnan(I0))~=0
    problem = 1
    WS = 'base';
    assignin(WS,'alpha',alpha);
    assignin(WS,'omega0',omega0);
    assignin(WS,'CJ',CJ);
    assignin(WS,'EJ',EJ);
    assignin(WS,'I_problem',I0)
    assignin(WS,'V_problem',V0)
    k = isnan(I0);
    I0(k)=0;
end
    
I = spline(V0,I0,V_list);

end
