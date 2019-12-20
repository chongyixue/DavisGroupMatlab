% approximately find where zero is in the input by looking for zero
% crossings
function index = find_zero_crossing(y)
index = find(y==0);
if isempty(index);
       sign_y = sign(y);
   if (sum(sign_y == 1) && sum(sign_y == -1))   
       % find the zero cross in the 
       zero_indic = sign_y(1:end-1) + sign_y(2:end);
       index = find(zero_indic == 0);
       %if max(index) < length(y)          
       % index = find(abs(y) == min([abs(y(index)),abs(y(index+1))]));
       %end
   else
       display('no zero found');
       return;
   end
end
end