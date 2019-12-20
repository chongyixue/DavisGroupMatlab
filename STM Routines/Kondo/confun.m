function [c, ceq] = confun(x)
% Nonlinear inequality constraints
c = [-x(3); x(3) - 2*pi];
% Nonlinear equality constraints
ceq = [];
end