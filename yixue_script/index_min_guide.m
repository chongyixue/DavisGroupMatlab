


A = [1 9 -2; 8 4 -5; -10 0 7];

A = imagmat;

[M,I] = min(A);
[MM,II] = min(M);

xindex = I(II);
yindex = II;

A(xindex,yindex)


