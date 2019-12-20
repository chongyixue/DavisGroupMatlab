%Yi Xue Chong
%2017/20/26
%take in map (square), return average spectrum data with error(plots too!)


function [x,y,datstd] = avg_spectrum_data(varargin)


plot = 0;
if nargin > 1
    color = varargin{2};
    plot = 1;
end

map = varargin{1};

data = map;
x = data.e*1000;
y = data.ave;

[nx ny nz] = size(data.map);

for i=1:nz
    tf = isfield(data,'regions');
    if tf == 0
        datvec = reshape(data.map(:,:,i),nx*ny,1);
        datstd(i) = std(datvec);
        clear datvec;
    else
        if isfield(data,'iclmask')==1
            M = data.iclmask;
        else
            M = data.xclmask;
        end
        cc = 1;
        for k=1:nx
            for l=1:ny
                if M(k,l)==1
                    datvec(cc) = data.map(k,l,i);
                    cc = cc+1;
                end
            end
        end
        datstd(i) =std(datvec);
        clear datvec;
    end
end
datstd = datstd/nx;
% graph_plot(x2,y2,datstd2','b',[data.name ' Average Spectrum mean error']);
% hold on
% graph_plot(x,y,datstd','r',[data.name ' Average Spectrum mean error']);

if plot == 1
    figure, errorbar(x,y,datstd,'color',color)
    hold on
    title('Average Spectrum');
    xlabel('E [meV]');
    ylabel('dI/dV(S)');
    hold off
end

end








