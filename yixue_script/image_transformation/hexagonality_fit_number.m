% 2020-12-17 YXC Hexagonality as a New Shape‑Based Descriptor of Object
% Vladimir Ilić1 · Nebojša M. Ralević1
% Hfit = overlap area with fitted hex / union of the two

function Hfit = hexagonality_fit_number(S,varargin)

plotornot = 1;
par = 0;
addtotitle="";


if nargin>1
    skipover = 0;
    for i=1:length(varargin)
        if skipover ~=0
            skipover = skipover-1;
        else
            switch varargin{i}
                case 'noplot'
                    skipover = 0;
                    plotornot = 0;
                case 'hexnumberknown' % enter [a,c,center(1),center(2),angle]
                    skipover  = 1;
                    par = varargin{i+1};
                case 'title'
                    skipover  = 1;
                    addtotitle = varargin{i+1};
                    
                otherwise
                    st = num2str(varargin{i});
                    fprintf(strcat('"',st,'" is not recognized as a property'));
            end

        end
    end
end


if length(par)==1
    [~,aS,cS,center,angle,~] = hexagonality_number(S);
else
    aS = par(1);
    cS = par(2);
    center = [par(3),par(4)];
    angle = par(5);
end
% coordinate of the hexagon
%       2   3   
%   1           4
%       6   5

%% hexXY gives coordinates of vertices of fitted hex
hexX = [-aS,-cS,cS,aS,cS,-cS,-aS]+center(1);
hexY = [0,aS-cS,aS-cS,0,cS-aS,cS-aS,0]+center(2);
hexXY = zeros(2,7);
hexXY(1,:) = reshape(hexX,1,[])-center(1);
hexXY(2,:) = reshape(hexY,1,[])-center(2);

R = [cosd(angle),-sind(angle);sind(angle),cosd(angle)];
newhexXY = R*hexXY;
newhexXY(1,:) = newhexXY(1,:)+center(1);
newhexXY(2,:) = newhexXY(2,:)+center(2);



fittedhex = makehex(aS,cS,center,angle);
% figure,imagesc(fittedhex);title('fitted hex');
% hold on
% plot(newhexXY(1,:),newhexXY(2,:),'w','LineWidth',5);


U = S | fittedhex;
Intersect = and(S,fittedhex);
% Excluded = xor(S,fittedhex);


% figure,imagesc(U);title('Union');
% figure,imagesc(Intersect);title('Intersect');
% figure,imagesc(Excluded);title('XOR');


Hfit = sum(sum(Intersect))/sum(sum(U));

if plotornot==1
    figure,imagesc(S);
    hold on
    plot(newhexXY(1,:),newhexXY(2,:),'k-','LineWidth',3);
    % plot(newhexXY(1,:),newhexXY(2,:),'w--','LineWidth',1);
    axis square; axis off;
    title(strcat(addtotitle," Shape with fitted hex, Hfit=",num2str(Hfit)));
end

    function hex = makehex(a,c,center,angle)
        [n1,n2] = size(S);
        a0 = 2*a;
        [X,Y] = meshgrid(linspace(1,n1,n1),linspace(1,n2,n2));
%         X = X-center(1);Y=Y-center(2);
        foci1 = [-c+center(1),center(2)];
        foci2 = [c+center(1),center(2)];
        D  = abs(X-foci1(1))+abs(X-foci2(1))+abs(Y-foci1(2))+abs(Y-foci2(2));
        hex = D<a0;
        hex = rotateAround(hex,center(1),center(2),-angle);
        
    end


end