function [] = plot_greenfn(pixel,switchE)

w1 = 0;
w2 = 10;

k = linspace(-pi,pi,pixel);
w = linspace(w1,w2,pixel);
[ki,wi]=meshgrid(k,w);

switch switchE
    case 1
        E = ki.^2;
    case 2
        E = ki;
    case 3
        E = -ki;
    otherwise 
        E = 1;
end


G = 1./(wi+1i*0.1-E);

p=2;

figure(p),surf(ki,wi,real(G),'FaceColor','interp','LineStyle', 'none')
view(2)
set(2,'Name','Real');
ylabel('\omega')
xlabel('k')
figure(p+1),surf(ki,wi,imag(G),'FaceColor','interp','LineStyle', 'none')
view(2)
set(3,'Name','Imaginary');
ylabel('\omega')
xlabel('k')