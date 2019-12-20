%%%%%%%
% CODE DESCRIPTION: Take fourier transform of map with given scaling.  The
% output is an absolute fourier transform map and a conjugate space scaling.
%   
% CODE HISTORY
%
% 080101 MA  Created
% 080131 MHH Minor revision to variable assignments
% 080204 MHH Added windowing option
%
%%%%%%%
function F = fourier_block2(data,window)

[sy,sx,sz]=size(data.map);

switch window
    case 'none'   
        z = 1;
    case 'sine'
        x = linspace(0,pi,sx);
        y = linspace(0,pi,sy);
        z = sin(x)'*sin(y);
    case 'kaiser'
        w = kaiser(sx,6);
        z = w*w';
    case 'gauss'
        w = gausswin(sx);
        z = w*w';
    case 'blackmanharris'
        w = blackmanharris(sx);
        z = w*w';
    case ''
        z = 1;
end
%apply filter
for k=1:sz
    filt(:,:,k) = data.map(:,:,k).*z;
end

for k=1:sz 
     ff = ifft2(filt(:,:,k));  
     %ff = fftshift(ff);          
     %f(:,:,k)=abs(ff);
     f = ff;
end
k0=2*pi/(max(data.r)-min(data.r));
k=linspace(-k0*sx/2,k0*sx/2,sx);
F = data;
F.map = f;
F.r = k;
end