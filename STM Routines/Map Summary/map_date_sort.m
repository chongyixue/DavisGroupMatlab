function sorted_map_summary = map_date_sort(map_summary)
n = length(map_summary);
%d = [map_summary.date];
date = zeros(n,3);
for i=1:n
    d = map_summary(i).date;
    [month r] = strtok(d,'/');
    [day r] = strtok(r,'/'); %#ok<STTOK>
    [year r] = strtok(r,'/'); %#ok<STTOK>
    date(i,:) = [str2double(year) str2double(month) str2double(day)];
end
sorted_map_summary = date;
    
end
