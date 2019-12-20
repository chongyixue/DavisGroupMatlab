function y = kondo_p(x)
l = 1;
V = 1;
y = (-x.^2 + l)/2 + (((-x.^2-l).^2 + V^2).^0.5)/2;
end

