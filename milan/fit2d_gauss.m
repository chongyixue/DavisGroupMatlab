function x=fit2d_gauss(x0)



% works for matrixes. if xdata is -1, it takes meshgrid, (0,0) like matrix
% element.

%func=['fit2d_aux_' func];
%func=str2func(func);


options = optimset('TolFun',1e-30,...
            'TolX',1e-30,'MaxIter',30,'MaxFunEvals',1e5, ...
            'Display','off');


x = fminunc(@fit2d_aux_gauss,x0,options);




function erro=fit2d_aux_gauss(x0)

ydata=evalin('base','ydata');


bg=x0(1);

a1=x0(2);

posy=x0(3);

posx=x0(4);

w= x0(5);
[sy,sx]=size(ydata);
[cy,cx]=ndgrid(1:sy,1:sx);

funvalue=bg+a1*exp(-((cy-posy).^2+(cx-posx).^2)/w.^2);

%compare

erro=sum(sum((funvalue-ydata).^2));













