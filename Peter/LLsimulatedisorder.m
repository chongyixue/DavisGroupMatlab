function enmap = LLsimulatedisorder(data,edmap)

% calculate Landau Level energies

nll = 5;
Ed = mean(mean(edmap));
[nx, ny, nz] = size(edmap);
cm=circlematrix([100,100],5,1,1);
enmap = ones(nx,ny,nll+3);
for i=-2:nll
    en(i+3) = (Ed*10^-3 +signPeter(i)* ( (4.1*10^5)^2*2*6.58211928*10^-16*8.5*abs(i) + (11*10^-3)^2)^0.5)*10^3;
    enmap(:,:,i+3) = en(i+3)*enmap(:,:,i+3);
end

edmapcc = edmap - min(min(edmap));

for k=-2:nll
    for i=1:nx
        for j=1:ny
            lb = (2*abs(k)+1)^0.5*26/(2.28*8.5);
            cm=circlematrix([nx,ny],lb,i,j);
            cm = double(cm);
            ledave = sum ( sum(edmapcc.*cm))/sum(sum(cm));
            enmap(i,j,k+3) = enmap(i,j,k+3)+ledave;
        end
    end
end

figure, img_plot4(enmap(:,:,1))

test = 1;




end