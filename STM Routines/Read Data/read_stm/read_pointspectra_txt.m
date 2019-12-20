function z=read_pointspectra_txt(file)

if file<10; file=['0' num2str(file)];
else file=num2str(file); end


dir='~/data/stm/txt/';
base='70508A';


str1=[base file, '.DI1.txt']
str2=[base file, '.DI2.txt']

[tmp,a]=textread(str1, '%f %f','headerlines',1);

[tmp,b]=textread(str2, '%f %f','headerlines',1);


%figure; plot(a);

%figure; plot(b)

z=a+i*b;
assignin('base', ['zz' file], z); 