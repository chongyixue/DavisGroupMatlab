

for k = 1:15
    for i = 1:400
        for j =1:400
            combine.map(i,j,23+k)=high.map(i,j,k)
        end
    end
end