function [s,varargout] = varargout_example(n)

n=round(n);
s = n;
for p = 1:n
    varargout{p} = p*2;
end
end