function [x, Enrm] = RL(A, b, x, MaxIts, x_exact, gamma, sigma_sq)
%
% [x, Enrm] = RL(A, b, x, MaxIts, x_exact, gamma, sigma_sq)
%
%  Richardson-Lucy iteration: a nonnegatively constrained iterative method.
%
%   Input: A  -  object defining the coefficient matrix.
%          b  -  Right hand side vector
%          x  -  initial guess 
% 
%   Optional Intputs:
%     MaxIts  -  number of iterations to perform (default = length(b(:)))
%    x_exact  -  if the exact solution is known, we can compute relative
%                errors at each iteration.
%      gamma  -  background radiation parameter
%   sigma_sq  -  instrument noise variance
% 
%   Output:
%          x  -  approximate solution
%       Enrm  -  norm of the true error at each iteration (if x_exact is known)
%
%   Code written by John Bardsley Feb. 2008
%
% check for inputs, and set default values (default tol will be
% set later)
%

disp(' '), disp('Beginning RL iterations')
%  Initialize necessary vectors and parameters.
x = max(x,sqrt(eps));
n = length(b(:));
if nargin < 4, MaxIts = n;, x_exact = []; gamma=0; sigma_sq=0;
elseif nargin < 5, x_exact = []; gamma=0; sigma_sq=0;
elseif nargin < 6, gamma=0; sigma_sq=0;
elseif nargin < 7, sigma_sq=0; end
if isempty(x), x = ones(size(b)); end
if isempty(MaxIts), MaxIts = n; end
if ~isempty(x_exact), nx_exact = norm(x_exact(:)); Enrm = norm(x(:)-x_exact(:))/nx_exact; end

% RL
k = 0; 
stop_flag = 0;
At1 = A'*ones(size(b));
bps = b + sigma_sq;
while stop_flag == 0
  k = k + 1;
  fprintf(' iter=%d Enrm=%3.5e\n',k,Enrm(k))
  
  x = x .* ( A' * ( bps ./ (A*x+gamma+sigma_sq) ) ) ./ At1;

  if ~isempty(x_exact), Enrm(k+1) = norm(x(:)-x_exact(:)) / nx_exact; end
  if Enrm(k+1)>Enrm(k)  
    disp('True Error Norm Increase'); 
  end
  if k==MaxIts
    stop_flag = 1;
    disp('Maximum iterations met.'); 
  end
end 
