%2017-10-01

down = up;
layers = 21;

for n=1:layers
    down.map(:,:,n)=up.map(:,:,layers-n+1);
end
