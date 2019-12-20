function ref_func = SM_reference_func(nr,nc,Q)
q1 = 2*pi/nr*abs((Q(1)-nr/2+1));
q2 = 2*pi/nr*abs((Q(2)-nc/2+1));
[X Y] = meshgrid(1:nc,1:nr);
ref_func.sin = sin(q1*Y + q2*X);
ref_func.cos = cos(q1*Y + q2*X);
%img_plot2(ref_func.cos);
%img_plot2(ref_func.sin);
end