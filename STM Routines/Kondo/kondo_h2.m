function y = kondo_h2(x,a,b,e0,l,V)

% l = 0.7414;
% V = 1;
% a= 1;
% b = 0.5;
% e0 = -1;

n = 4;
y = (a^2*(x-b).^n + e0 + l)/2 + (((a^2*(x-b).^n + e0 - l).^2 + V^2).^0.5)/2;
end