% 2020-5-14 YXC
% give two Bragg peaks, and return shear corrected image.

%%%%%%%%%%%%%%%%%%%%%%%%% input guide %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[newmap,q0,p,theta,alpha] = shear_correct_hex(map,Bragg1,Bragg2,varargin)
% map is in real space
% input Bragg1 and Bragg2 as [x,y] in terms of pixels. Decimals allowed.
% if p and theta known, can skip solving equations by varargin:
%   ... = shear_correct_hex(map,Bragg1,Bragg2,'ptheta',[p,theta])
% Other variable input arguemnts possible:
%  'centerofmass' - algorithm will find center of mass for Bragg peaks
%  'window' - determines how many pixels used for square windowing to find
%  COM. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% we assume there exist a perfect hexagon from the q-space of our
% triangular lattice, one of the symmetric axis of that hexagon (connecting
% two vertices) is shifted counter-clockwise by alpha from the Qx axis of
% our coordinate system. There is a shear in real space described by
% Sr = [1 p;0 1] (italics kinda skew) in a coordinate system angled by theta
% (counter-clockwise) relative to ours. In Q space this corresponds to a
% shift of S = [1 0;-p 1] (still in the shear coordinate system)
% Our measured Bragg peak Qthilde is a result of these operations:
% rotate CC to shear axis, shear, then de-rotate to our coordinate system.
% R(theta)^-1 S R(theta) Q=Qthilde
% Q1 and Q2 can be expressed in terms of alpha and q0 (length)
% similarlay Qthilde1 and 2 in terms of alpha, q0, p and theta.
% 4 non-linear simultaneous equations are solved numerically
% (the third Bragg peak is related by symmetry)

% in real space, R(theta)^-1 Sr R(theta) newmap = map
% the newmap has the recovered perfect hexagon Bragg peaks by doing
% R(theta)^-1 Sr^-1 R(theta) map = newmap

% care has to be taken as our img_obj_viewer Bragg peaks ij coordinate
% system is vertically inverted from the xy coordinate system.
% xy system: x increase to the right, y increase going up
% ij system (xpix and ypix from imagesc or img_obj_viewer): i increase to
%   the right,j increase going DOWN
% matrixij system: i increase going down, j increase going right
% also note: I did not take very good care about rotation direction etc,
% therefore the equation solving might be a bit funky, but all -ve errors
% cancel each other out.


function [newmap,q0,p,theta,alpha] = shear_correct_hex(map,Bragg1,Bragg2,varargin)

dofitting = 1;
centerofmass = 0;
COMneighbor = 3;

if nargin>3
    skipover = 0;
    for i=1:length(varargin)
        if skipover == 0
            property = varargin{i};
            switch property
                case 'ptheta'
                    dofitting = 0;
                    skipover = 1;
                    preval = varargin{i+1};
                    p = preval(1);
                    theta = preval(2);
                    alpha = 0;
                case 'centerofmass'
                    skipover = 0;
                    centerofmass = 1;
                case 'window'
                    skipover = 1;
                    COMneighbor = varargin{i+1};
                    centerofmass = 1;


            end
        else
            skipover =0;
        end
        
    end
    
end




nx = size(map.map,1);
center = ceil((nx+1)/2);



if dofitting==1
    if centerofmass == 1
        [Bragg1,~] = subpixelBragg(map,Bragg1(1),Bragg1(2),COMneighbor);
        [Bragg2,~] = subpixelBragg(map,Bragg2(1),Bragg2(2),COMneighbor);
    end
    Bgs = zeros(2,2);
    Bgs(1,:)= reshape(Bragg1-center,1,2);
    Bgs(2,:) = reshape(Bragg2-center,1,2);
    Bgs = pixij2xy(Bgs);
    q0av = mean(sqrt(sum(Bgs.^2,2)));
    
    
    % figure,plot(Bgs(:,1),Bgs(:,2));
    % hold on
    % plot(Bgs(1,1),Bgs(1,2),'ro')
    % siz = 20;
    % plot([-siz,siz],[0,0],'k');
    % plot([0,0],[-siz,siz],'k');axis off;axis square
    
    angle1 = atan2(Bgs(1,2),Bgs(1,1))*180/pi;
    angle2 = atan2(Bgs(2,2),Bgs(2,1))*180/pi;
    
    difang = qangle(Bgs(1,:),Bgs(2,:));
    if abs(difang-60)<abs(difang-120)
        % two vectors are approx 60 deg apart
        if mod(angle1-angle2,360)<120
            temp = Bgs(1,:);
            Bgs(1,:) = Bgs(2,:);
            Bgs(2,:) = temp;
        end
    else
        % two vectors are approx 120 deg apart
        Bgs(1,:) = -Bgs(1,:);
        angle1 = atan2(Bgs(1,2),Bgs(1,1))*180/pi;
        if mod(angle1-angle2,360)<120
            temp = Bgs(1,:);
            Bgs(1,:) = Bgs(2,:);
            Bgs(2,:) = temp;
        end
    end
    
    % figure,plot(Bgs(:,1),Bgs(:,2));
    % hold on
    % plot(Bgs(1,1),Bgs(1,2),'ro')
    % siz = 20;
    % plot([-siz,siz],[0,0],'k');
    % plot([0,0],[-siz,siz],'k');axis off;axis square
    % title('after correction')
    
    
    fun = @(x) root4d(x,Bgs);
    x0 = [q0av,0,0,0];
    x = fsolve(fun,x0);
    
    
    q0 = x(1);
    p = x(2);
    theta = x(3);
    alpha = x(4);
    
end


% due to the xy to matrix(for imagesc) transformation, CC rotation becomes
% clockwise, and the shear of [1 p;0 1] becomes [1 0;-p 1], hence the
% following difference between implimentation and explanation above.
% this is also a combination of how matlab defines its transformation
% matrix...I might have made some mistakes but -ve errors cancel out 
S = [1 0 0; -p 1 0; 0 0 1];
ang = -theta;
R = [cos(ang) sin(ang) 0; -sin(ang) cos(ang) 0; 0 0 1];
tform = affine2d(R^(-1)*S^(-1)*R);
newmap = map;
newmap.name = strcat(map.name,'_shearHexCorrected');
newmap.map = imwarp(map.map,tform);
newmap.map = croptosquare(newmap.map,nx);

newmap.ptheta = [p,theta]; %make the transformation available in the structure.


















%% functions
    function Bragxy=pixij2xy(Bragij)
        %assume Bragij is already centered-subtracted
        
        Bragxy(:,1) = Bragij(:,1);
        Bragxy(:,2) = -Bragij(:,2);
        
    end

    function Bragij=xy2pixij(Bragxy)
        %assume Bragij is already centered-subtracted
        
        Bragij = pixij2xy(Bragxy);
        
    end

    function map = croptosquare(old,nx)
        
        map = zeros(nx,nx);
        oldx = size(old,1);
        oldy = size(old,2);
        
        [nx1,nx2] = decidecropsize(oldx,nx);
        [ny1,ny2] = decidecropsize(oldy,nx);
        
        if oldx<nx
            if oldy<nx
                map(nx1:nx2,ny1:ny2) = old;
            else
                map(nx1:nx2,:) = old(:,ny1:ny2);
            end
        else
            if oldy<nx
                map(:,ny1:ny2)=old(nx1:nx2,:);
            else
                map = old(nx1:nx2,ny1:ny2);
            end
        end
        
        
    end

    function [nx1,nx2] = decidecropsize(size1,size2)
        if size1==size2
            nx1=1;
            nx2=size1;
        else
            if size1>size2
                big = size1;
                small = size2;
            else
                big = size2;
                small= size1;
            end
            
            nx1 = round((big-small)/2)+1;
            nx2 = nx1+small-1;
            
        end
    end



    function F2 = root4d(x,Bgs)
        
        q0 = x(1);
        p = x(2);
        theta = x(3);
        alpha = x(4);
        
        q1x = q0*cos(alpha)+p*q0*sin(theta)*(cos(theta-alpha))-Bgs(1,1);
        q1y = q0*sin(alpha)-p*q0*cos(theta)*(cos(theta-alpha))-Bgs(1,2);
        q2x = q0*cos(alpha+pi/3)+p*q0*sin(theta)*(cos(theta-alpha-pi/3))-Bgs(2,1);
        q2y = q0*sin(alpha+pi/3)-p*q0*cos(theta)*(cos(theta-alpha-pi/3))-Bgs(2,2);
        % q3x = q0*cos(alpha+2*pi/3)+p*q0*sin(theta)/(cos(theta-alpha-2*pi/3))-Bgs(3,1);
        % q3y = q0*sin(alpha+2*pi/3)-p*q0*cos(theta)/(cos(theta-alpha-2*pi/3))-Bgs(3,2);
        
        F2 = [q1x,q1y,q2x,q2y];
        % F2 = [q1x,q1y,q2x,q2y,q3x,q3y];
        
    end

    function Q = ShearTransformation(Qold)
        
        
        
    end


    function angle = qangle(v1,v2)
        A = sum(v1.*v2);
        v1mag = sqrt(sum(v1.^2));
        v2mag = sqrt(sum(v2.^2));
        B = v1mag*v2mag;
        angle = acos(A/B)*180/pi;
        
    end


    function Qnew = plotoriginalq2(q0,alpha)
        
        pts = zeros(7,2);
        pts(1,:) = [q0*cos(alpha),q0*sin(alpha)];
        pts(7,:) = pts(1,:);
        pts(4,:) = -pts(1,:);
        pts(2,:) = [q0*cos(alpha+pi/3),q0*sin(pi/3+alpha)];
        pts(5,:) = -pts(2,:);
        pts(3,:) = [q0*cos(2*pi/3+alpha),q0*sin(2*pi/3+alpha)];
        pts(6,:) = -pts(3,:);
        
        figure,plot(pts(:,1),pts(:,2));
        
        axis square;
        axis off;
        
        Qnew = pts(1:3,:);
        
    end



    function Qnew = plotoriginalq(q0,theta)
        
        pts = zeros(7,2);
        pts(1,:) = [q0*cos(theta),-q0*sin(theta)];
        pts(7,:) = pts(1,:);
        pts(4,:) = -pts(1,:);
        pts(2,:) = [q0*cos(pi/3-theta),q0*sin(pi/3-theta)];
        pts(5,:) = -pts(2,:);
        pts(3,:) = [-q0*cos(pi/3+theta),q0*sin(pi/3+theta)];
        pts(6,:) = -pts(3,:);
        
        figure,plot(pts(:,1),pts(:,2));
        
        axis square;
        axis off;
        
        Qnew = pts(1:3,:);
        
    end

    function [newBragg,phase] = subpixelBragg(map,x,y,window)
        x = round(x);y =round(y);
        %% first do background sub and FT
        mapsub = polyn_subtract(map,0,3); %dependency
        FTmap = fourier_transform2d(mapsub,'sine','amplitude','ft');
        [nx,~,~] = size(mapsub.map);
        
        %% mask and do weighted average (find center of mass)
        mask = zeros(nx,nx);
        mask(y-window:y+window,x-window:x+window)=FTmap.map(y-window:y+window,x-window:x+window);
        [X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,nx,nx));
        M = sum(sum(mask));
        Braggx = sum(sum(mask.*X))/M;
        Braggy = sum(sum(mask.*Y))/M;
        newBragg = [Braggx,Braggy];
        
        %% get phase of Bragg peak
        FTmap2 = fourier_transform2d(mapsub,'sine','phase','ft');
        % phase = pixel_val_interp(FTmap2.map,Braggx,Braggy);
        phase = FTmap2.map(round(Braggy),round(Braggx));
        % the real and imaginary part oscillate wildly, not a good idea to
        % interpolate
    end




end








