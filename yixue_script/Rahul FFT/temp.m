a = 4;
r = 28;
N = 128;
k = 2*pi/a;
x = linspace(0,r,N);
r = 1:1:N;
f = sin(k*x);
q = 1:1:N;
F = fft(f);
figure
plot(q,real(F),'b');
hold on
plot(q,imag(F),'r');
[~,max_q] = max(abs(real(F)))
q0 = abs((N+1)/2-max_q)
quality_initial=real(F(max_q))/imag(F(max_q))

ReF = real(F(max_q));
ImF = imag(F(max_q));
phase_shift = atan(ImF/ReF);
% dx= N*phase_shift/(q0*2*pi);
dx = 4;
f_shifted = ifft(F.*exp(-1i*2*pi/N*q*dx));
% f_shifted = circshift(f,round(dx));
F = fft(f_shifted);
figure
plot(r,f);
hold on
plot(r,real(f_shifted),'g')
figure
plot(q,real(F),'b');
hold on
plot(q,imag(F),'r');
quality_final=real(F(max_q))/imag(F(max_q))
