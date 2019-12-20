function dataout=smurdata(datain,std,pixel)
h = fspecial('gaussian',std,pixel);
dataout = imfilter(datain,h,'replicate');
end