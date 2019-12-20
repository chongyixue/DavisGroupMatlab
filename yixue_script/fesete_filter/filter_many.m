% 2019-7-31 YXC
% function to produce map based topo value

function varargout = filter_many(map,topo,varargin)
varargout = varargin;
if nargin>2
    pair = fix(nargin-2)/2;
    low = zeros(1,pair);
    high = zeros(1,pair);
    for i_filt = 1:pair
        low(i_filt) = varargin{i_filt*2-1};
        high(i_filt) = varargin{i_filt*2};
    end
end

[nx,ny,nz] = size(map.map);
temp = zeros(nx,ny,nz);
ave = zeros(pair,nz);
r = 0; b = 1; inc = 1/pair;
% figure,
hold on
for p = 1:pair    
    filter = filter_matrix(topo,low(p),high(p));
    for k = 1:nz
        temp(:,:,k) = filter;
    end
    av = map.map.*temp/(sum(sum(filter)));
    av = sum(av,1);
    av = sum(av,2);
%     size(squeeze(squeeze(av)))
    fmap = map;
    fmap.map = map.map.*temp+(1-temp).*av;
    fmap.ave = squeeze(av);
%     plot(map.e*1000,squeeze(squeeze(av)),'Color',[r 0 b])
%     hold on
    r = r+inc;b = b-inc;
%     squeeze(squeeze(av))
    ave(p,:) = squeeze(squeeze(av));
    fmap.name = strcat([map.name,'_',num2str(low(p)),'_',num2str(high(p))]);
    filtertopo = topo;
    filtertopo.map = filter;
    varargout{p*2-1} = filtertopo;
    varargout{p*2} = fmap;
end
r = 0; b = 1; inc = 1/pair;
legendcell = cell(1,pair);
figure,
for k = 1:pair
    plot(map.e*1000,ave(k,:),'Color',[r 0 b])
    hold on
    r = r+inc;b = b-inc;
    legendcell{k} = strcat(['range = ',num2str(low(k)),' to ',num2str(high(k))]);
end
legend(legendcell)
% ave
end





