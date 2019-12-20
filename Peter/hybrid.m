function [h1,h2]=hybrid(a,b,h)


 h_plus=(a+b)/2;
 h_minus=(a-b)/2;
% h1=(h_plus)-sqrt(h_minus.^2.+h^2);
% h2=(h_plus)+sqrt(h_minus.^2.+h^2);


h1=(h_plus)-sqrt(4*h.^2+(a-b).^2)/2;
h2=(h_plus)+sqrt(4*h.^2+(a-b).^2)/2;

