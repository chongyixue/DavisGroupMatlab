% 2018-10-10
% YXC
% varargin for no plotting

%dynes equation
function DOS = fake_gap(gap,noise_amp,points,varargin)

% gap = 0.2;
Gamma = 0.2*gap;
i = sqrt(-1);
delta = gap*(1+(rand-0.5)*0.3) + i*Gamma*(1+0.1*(rand-0.5));
E = 2.5*gap;
E = linspace(-E,E,points);
noise = (rand(1,length(E)))*noise_amp;
DOS = (real(E./(sqrt(E.^2-delta^2)))).^2;

for p = 1:length(E)
    DOS = DOS+noise;
end

if nargin==3
    figure()
    plot(E,DOS);
end