function data_loc=fese_nem_ord_anal_vb(data, varargin)
% vb uses the real-numbered position of atoms
% start timer
tic


% find the locations of the Se- and Fe-atoms, using LF-corrected data
data_loc = data;
phase_map = data_loc.phase_map;
[seloc, seloc2, vecSe1, vecSe2] =  atomic_pos_v2(phase_map,0,0, data);
[fe1loc, fe1loc2] =  atomic_pos_v2(phase_map,pi,0, data);
[fe2loc, fe2loc2] =  atomic_pos_v2(phase_map,0,pi, data);

% get the size of the STM data
[nx, ny, nz] = size(data.map);

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
                

%% crop the data to get rid of bad / distorted edges as a result of
%% LF-correction or shear correction

if isempty(varargin)
    dmap = data.map;
    [rx, ry] = size(dmap);
else
    sx = varargin{1};
    sy = varargin{2};
    ex = varargin{3};
    ey = varargin{4};
    
    dmap = data.map(sx:ex,sy:ey);
    [rx, ry] = size(dmap);
    
    cc1 = 1;
    
    for i=1:length(seloc2(1,:))
        if seloc2(1,i) > sx && seloc2(1,i) < ex && seloc2(2,i) > sy && seloc2(2,i) < ey 
            seloc3(1, cc1) = seloc2(1, i);
            seloc3(2, cc1) = seloc2(2, i);
            cc1 = cc1+1;
        end
    end
    seloc3(1, :) = seloc3(1, :) - sx +1;
    seloc3(2, :) = seloc3(2, :) - sy +1;
    
    cc1 = 1;
    
    for i=1:length(fe1loc2(1,:))
        if fe1loc2(1,i) > sx && fe1loc2(1,i) < ex && fe1loc2(2,i) > sy && fe1loc2(2,i) < ey 
            fe1loc3(1, cc1) = fe1loc2(1, i);
            fe1loc3(2, cc1) = fe1loc2(2, i);
            cc1 = cc1+1;
        end
    end
    
    fe1loc3(1, :) = fe1loc3(1, :) - sx +1;
    fe1loc3(2, :) = fe1loc3(2, :) - sy +1;
    
    cc1 = 1;
    
    for i=1:length(fe2loc2(1,:))
        if fe2loc2(1,i) > sx && fe2loc2(1,i) < ex && fe2loc2(2,i) > sy && fe2loc2(2,i) < ey 
            fe2loc3(1, cc1) = fe2loc2(1, i);
            fe2loc3(2, cc1) = fe2loc2(2, i);
            cc1 = cc1+1;
        end
    end
    
    fe2loc3(1, :) = fe2loc3(1, :) - sx +1;
    fe2loc3(2, :) = fe2loc3(2, :) - sy +1;
    
    cc1 = 1;
    
    
end


% sx = 10;
% sy = 64;
% ex = 876;
% ey = 930;





% find the exact location of the Fe-atoms in pixel coordinates

row1 = fe1loc3(2, :);
col1 = fe1loc3(1, :);
row2 = fe2loc3(2, :);
col2 = fe2loc3(1, :);
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
                    sqrt( (col2(i) - col1(dumind(1)))^2 + (row2(i) - row1(dumind(1)) )^2 );
                
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
Serow = seloc3(2, :);
Secol = seloc3(1, :);
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
                    sqrt( (Secol(i) - Secol(dumind(1)))^2 + (Serow(i) - Serow(dumind(1)) )^2 );
                
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

figure, plot(lcut1,'o-','Color','m','LineWidth', 2)
hold on
plot(lcut2, 's-','Color','c','LineWidth', 2)
hold off

toc
% plot the position of Se-, Fe-atoms and line cuts as overlay of data
change_color_of_STM_maps(dmap,'no')
hold on 

for i=1:length(lc1cell)
    pos = lc1cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'m','LineWidth',3);
%     test = 1;
end

for i=1:length(lc2cell)
    pos = lc2cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'c','LineWidth',3);
%     test = 1;
end


for i=1:length(seloc3(1,:))
            line([seloc3(1,i),seloc3(1,i)],[seloc3(2,i),seloc3(2,i)],'Color','y','LineWidth',2,'Marker','+','MarkerSize',12);
end

for i=1:length(fe1loc3(1,:))
            line([fe1loc3(1,i),fe1loc3(1,i)],[fe1loc3(2,i),fe1loc3(2,i)],'Color','r','LineWidth',2,'Marker','+','MarkerSize',12);
end

for i=1:length(fe2loc3(1,:))
            line([fe2loc3(1,i),fe2loc3(1,i)],[fe2loc3(2,i),fe2loc3(2,i)],'Color','b','LineWidth',2,'Marker','+','MarkerSize',12);
end


hold off


%%

% plot the average line cuts for Se to Se
figure, plot(lcutSe1,'o-','Color','m','LineWidth', 2)
hold on
plot(lcutSe2, 's-','Color','c','LineWidth', 2)
hold off

% plot the position of Se-, Fe-atoms and line cuts as overlay of data
change_color_of_STM_maps(dmap,'no')
hold on 

for i=1:length(selc1cell)
    pos = selc1cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'m','LineWidth',3);
%     test = 1;
end

for i=1:length(selc2cell)
    pos = selc2cell{i};
    plot([pos(1,1) pos(2,1)],[pos(1,2) pos(2,2)],'c','LineWidth',3);
%     test = 1;
end

for i=1:length(seloc3(1,:))
            line([seloc3(1,i),seloc3(1,i)],[seloc3(2,i),seloc3(2,i)],'Color','y','LineWidth',2,'Marker','+','MarkerSize',12);
end

for i=1:length(fe1loc3(1,:))
            line([fe1loc3(1,i),fe1loc3(1,i)],[fe1loc3(2,i),fe1loc3(2,i)],'Color','r','LineWidth',2,'Marker','+','MarkerSize',12);
end

for i=1:length(fe2loc3(1,:))
            line([fe2loc3(1,i),fe2loc3(1,i)],[fe2loc3(2,i),fe2loc3(2,i)],'Color','b','LineWidth',2,'Marker','+','MarkerSize',12);
end



hold off

toc


end