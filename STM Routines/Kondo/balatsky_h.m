function y = balatsky_h(x,a,e0,t,D,Q)

% l = 0.7414;
% V = 4.0082;
% a= -95.5076;
% e0 = 10.3015;

n = 2;
y = (2*a*(x).^n + 2*e0 +2*x*Q*cos(t+pi/4) + Q^2)/2 + (((2*x*Q*cos(t+pi/4) + Q^2).^2 + 4*D^2).^0.5)/2;
end