% 2018-10-11 
% map from 80905a00 
% crop 21,21 to 100,100 pixels to invert(93,62) and (89,120)

%use after-cropped and peak-inverted from Rahul
% call that map rahul (17 to 198) 
% p(1,:) = [94;64];
% p(2,:) = [90;118];

[gapmap,bad_x,bad_y] = gap_from_spline_function(rahul,0.15);
%results: bad percentage = 13.8

plot_random_badpoints;

%now get the average gap size from "good ones"
pixels = size(rahul.map,2);
layers = size(rahul.map,3);

sum = 0;
n_bad = length(bad_x);
n_total = pixels*pixels;
for x = 1:pixels
    for y = 1:pixels
        sum = sum + gapmap.map(y,x,4);
    end
end
sum = sum - 10*n_bad;
gap_avg = sum/(n_total-n_bad);
% = 0.085

gapmap2 = gapmap;
gapmap2.name = [gapmap2.name '-with_avg_gap'];
for k=1:length(bad_x)
    x = bad_x(k);y = bad_y(k);
    gapmap2.map(y,x,4) = gap_avg;
end
img_obj_viewer_test(gapmap2);



%now look at unprocessed data, make gapmap,call it gapmap3
[gapmap3,bad_x,bad_y] = gap_from_spline_function(obj_80905a00_G_crop,0.15);
goodlist = [];
for x = 1:pixels
    for y = 1:pixels
        goodlist(end+1) = gapmap3.map(y,x,1);
        for k = 1:length(bad_x)
            if x==bad_x(k) && y==bad_y(k)
                goodlist(end) = [];
            end
        end
    end
end
% sqrt(var(goodlist)) = 0.0078;


%generate gapmap histogram
avglist = [];
for x = 1:pixels
    for y = 1:pixels
       avglist(end+1) = gapmap2.map(y,x,4);
    end
end


h1 = histogram(avglist,200);
hold on
xlim([0 max(avglist)]);
title('Unfiltered gapmap histogram - bad pixels replaced')
xlabel('mV')

h2 = histogram(goodlist,100);
title('unfiltered')


%fakegapmap
%now what is the filtered histogram?
avglist = [];
for x = 1:pixels
    for y = 1:pixels
       avglist(end+1) = fakegapmap2.map(y,x,1);
    end
end
histogram(avglist,500); hold on;
title('fakegapmap q-filtered');

%splinefit average gap
[spline_x,spline_y,dif,leftgap,rightgap] = spline_fit_avg(map,0,0.3);
(rightgap-leftgap)*0.5


    
    
    
    
    