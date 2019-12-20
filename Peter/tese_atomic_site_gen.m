function data_loc=tese_atomic_site_gen(data)
% start timer
tic

% find the locations of the Se- and Fe-atoms, using LF-corrected data
data_loc = data;
phase_map = data_loc.phase_map;
seloc =  atomic_pos(phase_map,0,0);
fe1loc =  atomic_pos(phase_map,pi,0);
fe2loc =  atomic_pos(phase_map,0,pi);

% get the size of the STM data
[nx, ny, nz] = size(data.map);

% find the approximate vectors connecting Se-atoms
[row1, col1] = find(seloc == 1);
[row2, col2] = find(seloc.' == 1);

vecSe1 = [col1(2)-col1(1), row1(2)-row1(1)];
vecSe2 = [row2(2)-row2(1), col2(2)-col2(1),];

% norm of vector
vnse1 = sqrt( vecSe1(1)^2 + vecSe1(2)^2 );
vnse2 = sqrt( vecSe2(1)^2 + vecSe2(2)^2 );

% normalize vectors
nvecSe1 = [vecSe1(1); vecSe1(2)]/ vnse1;
nvecSe2 = [vecSe2(1); vecSe2(2)]/ vnse2;

% find the approximate vectors connecting Fe-atoms
vec1 = (vecSe1 + vecSe2)/2;
vec2 = (vecSe1 - vecSe2)/2;

% norm of vector
vnfe1 = sqrt( vec1(1)^2 + vec1(2)^2 );
vnfe2 = sqrt( vec2(1)^2 + vec2(2)^2 );

% normalize vectors
nvec1 = [vec1(1); vec1(2)]/ vnfe1;
nvec2 = [vec2(1); vec2(2)]/ vnfe2;
                
clear ro1 row2 col1 col2;

% crop the data to get rid of bad / distorted edges as a result of
% LF-correction
sx = 10;
sy = 64;
nx = 876;
ny = 930;


dmap = data.map(sx:nx,sy:ny);
[rx, ry] = size(dmap);

seloc = seloc(sx:nx,sy:ny);
fe1loc = fe1loc(sx:nx,sy:ny);
fe2loc = fe2loc(sx:nx,sy:ny);

% find the exact location of the Fe-atoms in pixel coordinates
[row1, col1] = find(fe1loc == 1);
[row2, col2] = find(fe2loc == 1);
lc1 = length(row1);
lc2 = length(row2);


lcut1 = [];
lcut2 = [];
cc1 = 1;
cc2 = 1;



for i=1:lc2
    % calculate expected position of 4 nearest neighbor Fe-atoms using
    % approximate vectors
    ppx(1) = col2(i)+vec1(1);
    ppy(1) = row2(i)+vec1(2);
    
    ppx(2) = col2(i)-vec1(1);
    ppy(2) = row2(i)-vec1(2);
    
    ppx(3) = col2(i)+vec2(1);
    ppy(3) = row2(i)+vec2(2);
    
    ppx(4) = col2(i)-vec2(1);
    ppy(4) = row2(i)-vec2(2);
    
    for k = 1 : 4
        % check if nearest neighbor Fe-atom is in side the limits of map
        if ppx(k) < 1 || ppx(k) > rx
        elseif ppy(k) < 1 || ppy(k) > ry
        else
            % calculate the distance between estimated Fe-position and
            % actual position based on LF-data 
            for j=1:lc1
                distx(j) = col1(j) - ppx(k); 
                disty(j) = row1(j) - ppy(k);
                tdist(j) = sqrt ( distx(j)^2 + disty(j)^2 );
            end
            % find the estimated psoition closest to actual Fe-position
            [dum, dumind] = sort(tdist,'ascend');
            
            % check that you haven't found a faulty nearest neighbor, for example due to being at the edge of map 
            
            if tdist(dumind(1)) > vnfe1
            elseif tdist(dumind(1)) > vnfe2
            else
                    % calculate vector between Fe-atom and its nearest
                    % neighbor
                cvec = [col2(i) - col1(dumind(1)), row2(i) - row1(dumind(1))]/...
                    sqrt( (col2(i) - col1(dumind(1)))^2 + (col2(i) - col1(dumind(1)) )^2 );
                
                % caluclate the angle between expected vectors and actual
                % vector, use this to decide if the vectors connects along
                % bond a or bond b
                dec1 = abs( acosd( cvec * nvec1 ) );
                dec2 = abs( acosd( cvec * nvec2 ) );
                dec3 = abs( acosd( cvec * -nvec1 ) );
                dec4 = abs( acosd( cvec * -nvec2 ) );
                
                [dum2, dum2ind] = min([dec1, dec2, dec3, dec4]);
                
                    if dum2ind == 1 || dum2ind == 3

                        lcut = line_cut_v3(dmap,[col1(dumind(1)), row1(dumind(1))]...
                            ,[col2(i), row2(i)],0);

                        if isempty(lcut1)
                            lcut1 = lcut;
                        else
                            if length(lcut1) == length(lcut)
                                lcut1 = (lcut1+lcut);
                            else
                                % if length of line cuts is not the same
                                % interpolate data to make it the same
                                % length
                                x = 1:1:length(lcut);
                                xi = linspace(1,length(lcut),length(lcut1));
                                yi = interp1q(x',lcut,xi');
                                lcut1 = (lcut1+yi);
                            end

                        end
                        % save location of start and end point for plotting
                        % purposes later
                        lc1cell{cc1} = [col1(dumind(1)), row1(dumind(1))...
                            ;col2(i), row2(i)];

                        cc1 = cc1+1;

                    else

                        lcut = line_cut_v3(dmap,[col1(dumind(1)), row1(dumind(1))]...
                            ,[col2(i), row2(i)],0);

                        if isempty(lcut2)
                            lcut2 = lcut;
                        else
                            if length(lcut2) == length(lcut)
                                lcut2 = (lcut2+lcut);
                            else
                                % if length of line cuts is not the same
                                % interpolate data to make it the same
                                % length
                                x = 1:1:length(lcut);
                                xi = linspace(1,length(lcut),length(lcut2));
                                yi = interp1q(x',lcut,xi');
                                lcut2 = (lcut2+yi);
                            end
                        end
                        % save location of start and end point for plotting
                        % purposes later
                        lc2cell{cc2} = [col1(dumind(1)), row1(dumind(1))...
                            ;col2(i), row2(i)];
                        cc2 = cc2+1;

                    end
                    
            end
            
        end
    test = 1;
    clear tdist distx disty;
    close all;
    end
    %%
    
    
   
end

cc1 = cc1 - 1;
cc2 = cc2 - 1;
% calculate the mean line cut by dividing through the total number of lines
lcut1 = lcut1/cc1;
lcut2 = lcut2/cc2;
% plot the average line cuts for Fe to Fe
%%


% find the exact location of the Se-atoms in pixel coordinates
[Serow, Secol] = find(seloc == 1);
lc1 = length(Serow);


lcutSe1 = [];
lcutSe2 = [];
cc1 = 1;
cc2 = 1;



for i=1:lc1
    % calculate expected position of 4 nearest neighbor Se-atoms using
    % approximate vectors
    ppx(1) = Secol(i)+vecSe1(1);
    ppy(1) = Serow(i)+vecSe1(2);
    
    ppx(2) = Secol(i)-vecSe1(1);
    ppy(2) = Serow(i)-vecSe1(2);
    
    ppx(3) = Secol(i)+vecSe2(1);
    ppy(3) = Serow(i)+vecSe2(2);
    
    ppx(4) = Secol(i)-vecSe2(1);
    ppy(4) = Serow(i)-vecSe2(2);
    
    for k = 1 : 4
        % check if nearest neighbor Se-atom is in side the limits of map
        if ppx(k) < 1 || ppx(k) > rx
        elseif ppy(k) < 1 || ppy(k) > ry
        else
            % calculate the distance between estimated Se-position and
            % actual position based on LF-data 
            for j=1:lc1
                distx(j) = Secol(j) - ppx(k); 
                disty(j) = Serow(j) - ppy(k);
                tdist(j) = sqrt ( distx(j)^2 + disty(j)^2 );
            end
            % find the estimated psoition closest to actual Se-position
            [dum, dumind] = sort(tdist,'ascend');
            
            % check that you haven't found a faulty nearest neighbor, for example due to being at the edge of map 
            
            if tdist(dumind(1)) > vnse1
            elseif tdist(dumind(1)) > vnse2
            else
                    % calculate vector between Fe-atom and its nearest
                    % neighbor
                cvec = [Secol(i) - Secol(dumind(1)), Serow(i) - Serow(dumind(1))]/...
                    sqrt( (Secol(i) - Secol(dumind(1)))^2 + (Secol(i) - Secol(dumind(1)) )^2 );
                
                % caluclate the angle between expected vectors and actual
                % vector, use this to decide if the vectors connects along
                % bond a or bond b
                dec1 = abs( acosd( cvec * nvecSe1 ) );
                dec2 = abs( acosd( cvec * nvecSe2 ) );
                dec3 = abs( acosd( cvec * -nvecSe1 ) );
                dec4 = abs( acosd( cvec * -nvecSe2 ) );
                
                [dum2, dum2ind] = min([dec1, dec2, dec3, dec4]);
                
                    if dum2ind == 1 || dum2ind == 3

                        lcut = line_cut_v3(dmap,[Secol(dumind(1)), Serow(dumind(1))]...
                            ,[Secol(i), Serow(i)],0);

                        if isempty(lcutSe1)
                            lcutSe1 = lcut;
                        else
                            if length(lcutSe1) == length(lcut)
                                lcutSe1 = (lcutSe1+lcut);
                            else
                                % if length of line cuts is not the same
                                % interpolate data to make it the same
                                % length
                                x = 1:1:length(lcut);
                                xi = linspace(1,length(lcut),length(lcutSe1));
                                yi = interp1q(x',lcut,xi');
                                lcutSe1 = (lcutSe1+yi);
                            end

                        end
                        % save location of start and end point for plotting
                        % purposes later
                        selc1cell{cc1} = [Secol(dumind(1)), Serow(dumind(1))...
                            ;Secol(i), Serow(i)];

                        cc1 = cc1+1;

                    else

                        lcut = line_cut_v3(dmap,[Secol(dumind(1)), Serow(dumind(1))]...
                            ,[Secol(i), Serow(i)],0);

                        if isempty(lcutSe2)
                            lcutSe2 = lcut;
                        else
                            if length(lcutSe2) == length(lcut)
                                lcutSe2 = (lcutSe2+lcut);
                            else
                                % if length of line cuts is not the same
                                % interpolate data to make it the same
                                % length
                                x = 1:1:length(lcut);
                                xi = linspace(1,length(lcut),length(lcutSe2));
                                yi = interp1q(x',lcut,xi');
                                lcutSe2 = (lcutSe2+yi);
                            end
                        end
                        % save location of start and end point for plotting
                        % purposes later
                        selc2cell{cc2} = [Secol(dumind(1)), Serow(dumind(1))...
                            ;Secol(i), Serow(i)];
                        cc2 = cc2+1;

                    end
                    
            end
            
        end
    test = 1;
    clear tdist distx disty;
    close all;
    end
    %%
    
    
   
end

cc1 = cc1 - 1;
cc2 = cc2 - 1;
% calculate the mean line cut by dividing through the total number of lines
lcutSe1 = lcutSe1/cc1;
lcutSe2 = lcutSe2/cc2;


%%

figure, plot(lcut1,'o-','Color','c','LineWidth', 2)
hold on
plot(lcut2, 's-','Color','m','LineWidth', 2)
hold off

toc
% plot the position of Se-, Fe-atoms and line cuts as overlay of data
change_color_of_STM_maps(data.map(sx:nx,sy:ny),'no')
hold on 

for i=1:length(lc1cell)
    pos = lc1cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'c','LineWidth',3);
%     test = 1;
end

for i=1:length(lc2cell)
    pos = lc2cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'m','LineWidth',3);
%     test = 1;
end

for i=1:(nx-sx)
    for j=1:(ny-sy)
        if seloc(i,j,1) == 1
            line([j,j],[i,i],'Color','y','LineWidth',2,'Marker','+','MarkerSize',12);
        end
    end
end

for i=1:(nx-sx)
    for j=1:(ny-sy)
        if fe1loc(i,j,1) == 1
            line([j,j],[i,i],'Color','r','LineWidth',2,'Marker','+','MarkerSize',12);
        end
    end
end

for i=1:(nx-sx)
    for j=1:(ny-sy)
        if fe2loc(i,j,1) == 1
            line([j,j],[i,i],'Color','b','LineWidth',2,'Marker','+','MarkerSize',12);
        end
    end
end

hold off


%%

% plot the average line cuts for Se to Se
figure, plot(lcutSe1,'o-','Color','c','LineWidth', 2)
hold on
plot(lcutSe2, 's-','Color','m','LineWidth', 2)
hold off

% plot the position of Se-, Fe-atoms and line cuts as overlay of data
change_color_of_STM_maps(data.map(sx:nx,sy:ny),'no')
hold on 

for i=1:length(selc1cell)
    pos = selc1cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'c','LineWidth',3);
%     test = 1;
end

for i=1:length(selc2cell)
    pos = selc2cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'m','LineWidth',3);
%     test = 1;
end

for i=1:(nx-sx)
    for j=1:(ny-sy)
        if seloc(i,j,1) == 1
            line([j,j],[i,i],'Color','y','LineWidth',2,'Marker','+','MarkerSize',12);
        end
    end
end

for i=1:(nx-sx)
    for j=1:(ny-sy)
        if fe1loc(i,j,1) == 1
            line([j,j],[i,i],'Color','r','LineWidth',2,'Marker','+','MarkerSize',12);
        end
    end
end

for i=1:(nx-sx)
    for j=1:(ny-sy)
        if fe2loc(i,j,1) == 1
            line([j,j],[i,i],'Color','b','LineWidth',2,'Marker','+','MarkerSize',12);
        end
    end
end

hold off

toc


end