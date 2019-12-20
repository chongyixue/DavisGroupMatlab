function [offsety, cslope, cpower] = scattermassgap(edmap,massgapmap)

% edmap = outlierscorrectplushisto(edmap(:,:,2),25);
% massgapmap = outlierscorrectplushisto(massgapmap(:,:,2),25);

[nx,ny,nz] = size(edmap);
mvec = (reshape(massgapmap(:,:,2),nx*ny,1)).^2;
edvec = reshape(edmap(:,:,2),nx*ny,1);

mdl = fitlm(mvec,edvec)


% guess = [min(edvec),1,2];
guess = [0,0,0];

low = [-inf,-inf,-inf];
upp = [inf, inf, inf];

[y_new, p,gof]=powerlaw1(edvec,mvec,guess,low,upp);
offsety = p.a
cslope = p.b
cpower = p.c


guess = [0,0,0];

low = [-inf,-inf,1];
upp = [inf, inf, inf];

[y_new2, p2,gof]=powerlaw1(edvec,mvec,guess,low,upp);
offsety = p2.a
cslope = p2.b
cpower = p2.c



figure, plot(mvec,edvec,'k.',mvec,y_new,'r',mvec,y_new2,'b','LineWidth',2);
figure, loglog(mvec,edvec,'k.',mvec,y_new,'r',mvec,y_new2,'b','LineWidth',2);
test=1;

end