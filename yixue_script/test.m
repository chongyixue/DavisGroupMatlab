

if length(B)>length(C)
    large = B;
    small = C;
else
    large = C;
    small = B;
end

%initiate new image
new = large;

l_large=length(large);
l_small=length(small);

% check even or odd
parity_large = mod(l_large,2);
parity_small = mod(l_small,2);

if parity_large == parity_small
    return
else
    small = pix_dim(small,l_small+1);
    l_small = length(small);
end

%now here is where the adding actually happens

skip = round(0.5*(l_large-l_small));
start = round(1+skip);
stop = round(l_large-skip);
for i=start:stop
    for j=start:stop
        new(i,j)=small(i-skip,j-skip)+large(i,j);
    end
end

%make sure output pixel is even
%added = pix_dim(new,length(new)+mod(length(new),2));

