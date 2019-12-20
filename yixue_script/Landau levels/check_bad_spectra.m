% YXC 2019-3-29
% check in spectra is good or bad
% bad spectra is those that has huge cumulative changes

function good = check_bad_spectra(map,pixx,pixy,varargin)

signal = squeeze(map.map(pixy,pixx,:));

% disregard first and last datapoint
sig1 = signal(2:end-2);
sig2 = signal(3:end-1);
difsig = abs(sig1-sig2);
cumulative = sum(difsig);

if nargin>3
    diff_cumulative =  varargin{1};
    if cumulative>diff_cumulative
        good = 0;
    else
        good = 1;
    end
else
    good = cumulative;
end


