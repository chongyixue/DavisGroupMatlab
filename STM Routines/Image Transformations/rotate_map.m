function new_map = rotate_map(map,angle)
new_map = imrotate(map,angle,'nearest','crop');
end