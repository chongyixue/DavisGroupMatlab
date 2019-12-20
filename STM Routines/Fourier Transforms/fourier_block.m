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
function [k,f]=fourier_block(map,r,window)

[sy,sx,sz]=size(map);

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
    case ''
        z = 1;
end
for k=1:sz
    f(:,:,k) = map(:,:,k).*z;
end

for k=1:sz 
     ff = fft2(f(:,:,k));  
     %ff = fftshift(ff);          
     f = ff;
     %f(:,:,k)=abs(ff);
end
k0=2*pi/(max(r)-min(r));
k=linspace(-k0*sx/2,k0*sx/2,sx);
end