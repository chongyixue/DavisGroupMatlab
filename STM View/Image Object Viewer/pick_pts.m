function A = pick_pts(img)
img_plot2(img);
button = 0;
count = 0;
while(1)
    count = count + 1;
    [x,y, button] = ginput(1);
    if button == 1
        A(count,1) = round(x); A(count,2) = round(y);
        hold on; plot(A(count,1),A(count,2),'rx');
    else
        break;
    end
end


end
