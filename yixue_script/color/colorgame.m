% 2020-12-23 YXC


function  colorgame(varargin)
%% GUI dimensions 
width = 800; height = width*2/3;
column1left = 1;
column1right = 11;
labelfontsize = 12;

%% keeping score
ind = 0; % index of the firstcolor(not too useful after granularity changed).

t1 = 0;t2 = 0;
correct = 0;
total = 0;
correctindexlist = [];
wrongindexlist = [];
timeout = 60; % (seconds) upper limit - nobody takes that long. probably idle

grand_index = 1;
% [index,startRGB,endRGB,time,rightorwrong-1-correct,0-wrong)]
scorematrix = zeros(20,8);


if nargin>0
    skipover = 0;
    for i=1:length(varargin)
        if skipover ~=0
            skipover = skipover-1;
        else
            switch varargin{i}
                case 'previous_score'
                    skipover = 1;
                    scorematrix = varargin{i+1};
                    grand_index = size(scorematrix,1)+1;
                    
                case 'normalizeall'
                    skipover = 1;
                    normalizeall = varargin{i+1};
                    
                otherwise
                    st = num2str(varargin{i});
                    fprintf(strcat('"',st,'" is not recognized as a property'));
            end
            
        end
    end
    
    
end



%% GUI

h1 = figure(...
    'Units','characters',...
    'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...%'MenuBar','none',...
    'Name',strcat('colormap maker GUI ',''),...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[50 50 width height],...
    'Resize','off',...
    'Visible','on');



buttonwidth = width/20;
startbutton = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[8*width/20 height*0.8 buttonwidth*2 height*0.06],...
    'String','Start',...
    'Callback',@start_Callback);%,...

stopbutton = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[10*width/20 height*0.8 buttonwidth*2 height*0.06],...
    'String','Stop',...
    'Callback',@stop_Callback);%,...

startcolor = [0,0,0];
secondcolor = [0,0,0];
speciallocation = 1;

%% 9-button group
Nchoice = 9;
perrow = 3;
colorbuttons = cell(1,Nchoice);
W = height*0.5;
space = W*0;
w = (W-(perrow-1)*space)/perrow;
i=1;
left = 0.5*(width-W);
top = width*0.5;
row = 1;col=1;
while i<Nchoice+1
    colorbuttons{i} =  uicontrol('Parent',h1,...
        'Style','pushbutton',...
        'Units','pixels',...
        'Position',[left+(col-1)*(space+w),top-w-(row-1)*(w+space),w,w],...
        'BackgroundColor',startcolor,...
        'Callback',{@colorchoosing_Callback,i});
    
    i=i+1;
    col=col+1;
    if col>perrow
        row=row+1;
        col=1;
    end
end

score_display = uicontrol('Parent',h1,...
    'Style','text',...
    'Units','pixels',...
    'Position',[0.5*width+W*0.5+width*0.1 height*0.8 W*0.2 W*0.2],...
    'String','Score',...
    'Callback',@start_Callback);%,...



%% colorcube
granularizemorefactor = 3;
granularity = 11;
colordist = 1/(granularity-1);
% colordist = 0.1/(granularity-1);

rgb = linspace(0,1,granularity);

[R,G,B]=meshgrid(rgb,rgb,rgb);
R = reshape(R,[],1);
G = reshape(G,[],1);
B = reshape(B,[],1);
startingcolorchoices = [R,G,B];
N = size(startingcolorchoices,1);








%% callback functions

    function granularize_more(factor)   
        R2 = [];G2=[];B2=[];
        for ii=1:N
            if sum(ismember(correctindexlist,ii))==1
                [Rnew,Gnew,Bnew]=meshgrid(linspace(max(0,R(ii)-colordist/2),min(1,R(ii)+colordist/2),factor+1),...
                    linspace(max(0,G(ii)-colordist/2),min(1,G(ii)+colordist/2),factor+1),...
                    linspace(max(0,B(ii)-colordist/2),min(1,B(ii)+colordist/2),factor+1));
                Rnew = reshape(Rnew,[],1);
                Gnew = reshape(Gnew,[],1);
                Bnew = reshape(Bnew,[],1);
                R2 = [R2',Rnew']';
                G2 = [G2',Gnew']';
                B2 = [B2',Bnew']';
            end
        end
        R = R2;G =G2;B=B2;
        startingcolorchoices = [R,G,B];
        N = size(startingcolorchoices,1);
        colordist = colordist/factor;
        granularity = (1/colordist)+1;
        correctindexlist=[];
        wrongindexlist = [];
        startcolor = getstartcolor;
        start_Callback;
    end


    function stop_Callback(~,~)
        scorematrix(grand_index:end,:)=[];
        prompt={'Workspace Variable Name'};
        name='Save Result to Workspace';
        defaultanswer= {'ColorGameResult'};
        answer = inputdlg(prompt,name,1,defaultanswer);
        if strcmp(answer{1},'')
            return;
        else
            assignin('base',answer{1},scorematrix);
        end
    end

    function colorchoosing_Callback(~,~,index)
        t2 = clock;
        timediff = etime(t2,t1);
        if timediff<timeout
            if index == speciallocation
                correct=correct+1;
                rightorwrong = 1;
                correctindexlist(end+1)=ind;
            else
                rightorwrong = 0;
                wrongindexlist(end+1)=ind;
            end
            total=total+1;
            
            
            % write to scorematrix
            newrow = [startcolor,secondcolor,timediff,rightorwrong];
            scorematrix(grand_index,:)=newrow;
            score_display.String = strcat('Score=',num2str(correct),'/',num2str(total));
            grand_index = grand_index+1;
        end
        start_Callback;
    end


    function start_Callback(~,~)
        t1 = clock;
        startcolor = getstartcolor;
        if length(startcolor)==1
            granularize_more(granularizemorefactor);
        else
            secondcolor = get_nearby_color(startcolor,colordist);
            speciallocation = randi(Nchoice);
            for ii=1:Nchoice
                
                colorbuttons{ii}.BackgroundColor = startcolor;
            end
            colorbuttons{speciallocation}.BackgroundColor = secondcolor;
        end
    end



%% function

    function startcol = getstartcolor

        if length(correctindexlist)+length(wrongindexlist)<N
            ind = ceil(rand(1,1)*(N));
            while sum(ismember([correctindexlist,wrongindexlist],ind))==1
                ind = ceil(rand(1,1)*(N));
            end

            startcol = startingcolorchoices(ind,:);    
        else
            startcol = 0;
%             granularize_more(granularizemorefactor);  
        end
    end

    function secondcolor = get_nearby_color(startcolor,colordist)
        
        needchanging = round(rand(1,3));
        if sum(needchanging)==0
            needchanging(randi(3))=1;
        end
        share = rand(1,3).*needchanging;
        share = share/sum(share);
        share = (round(rand(1,3))*2-1).*share;
        secondcolor = startcolor+share*colordist;
        ifover = secondcolor>1;
        ifunder = secondcolor<0;
        secondcolor = ifover.*(2*startcolor-secondcolor)+...
            ifunder.*(2*startcolor-secondcolor)+...
            (1-(ifover+ifunder>0.5)).*secondcolor;
    end



end
