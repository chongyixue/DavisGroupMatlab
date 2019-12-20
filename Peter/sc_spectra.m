function sc_spectra(spec, ev, varargin)

% superconducting order parameter symmetry, "swave" or "dwave", meaning is
% it fully gapped or not, flat bottom gap or v-shaped spectrum (means
% s-wave with accidental nodes has to be treated as a d-wave SC)
scos = varargin{1};

% hms = how much spectrum, half or complete; is it a complete spectrum,
% below and above the chemical potential or only one of the two
hms = varargin{2};

%aop = average or point / pixel spectrum, average or point; is it the
%average spectrum of a map, or a single point spectrum of a map
aop = varargin{3};

maxthresh = min(spec);
minthresh = max(spec);
sel = (max(spec)-min(spec))/4;
[peakloc, peakmag] = peakfinder(spec, sel, thresh, extrema)
% [peakloc, peakmag] = peakfinder(x0, sel, thresh, extrema)
%       x0 - A real vector from the maxima will be found (required)
%       sel - The amount above surrounding data for a peak to be
%           identified (default = (max(x0)-min(x0))/4). Larger values mean
%           the algorithm is more selective in finding peaks.
%       thresh - A threshold value which peaks must be larger than to be
%           maxima or smaller than to be minima.
%       extrema - 1 if maxima are desired, -1 if minima are desired
%           (default = maxima, 1)

spdevr = abs( spec(2:end)./spec(1:end-1) -1.1);

spdevl = abs( spec(1:end-1)./spec(2:end) -1.1);

end