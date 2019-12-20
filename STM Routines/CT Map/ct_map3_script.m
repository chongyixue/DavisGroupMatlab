%%
g = squeeze(squeeze(G.map(59,100,:)));
y = [g(1:53); g(62:end)];
x = [G.e(1:53) G.e(62:end)];

%% 
[p,S] = polyfit(x(1:53)',y(1:53),9);
%toc
f = polyval(p,x(1:53));
figure; plot(x(1:53),f,'b',x(1:53),y(1:53),'r.');
%figure; plot(1:90,f,'b',1:90,y,'r');
%figure; plot(G.e,p(1)*(G.e.^2) + p(2)*G.e + p(3));
%hold on; plot(G.e,g,'r')
figure; plot(diff(f));

%%
der = diff(f);
for i=52:-1:2
    if der(i) < 0 && der(i-1) > 0
        break;
    end
end
figure; plot(x(1:53),f,'b.');
hold on; plot(x(i+1),f(i+1),'ro');
        
%%
x = energy;
 y = avg_spect; 
            [p,S] = polyfit(x',y,9);
            f = polyval(p,x,S);
            figure; plot(x,y,'rx'); hold on; plot(x,f);
            residual = [(y(1:6)'-f(1:6)) (y(end-6:end)' - f(end-6:end))];
            %residual = 0;
            r = norm(residual)       
            %stat_map(i,j) = r;
            %new_map(i,j,:) = f;
%%            
  
        Y1 = diff(f,1)./diff(energy,1);
        figure; plot(Y1);
        %%
        avg1 = Y1(4);
        avg2 = Y1(end-3);
        avg3 = mean(f(30:50)); 
        b1 = f(4) - avg1*energy(4); %f(6) for 80913
        b2 = f(end-3) - avg2*energy(end-3);
%%
        r1 = ((avg3-b1)/avg1);
        r2 = ((avg3-b2)/avg2);
        %ctmap(i,j) = r1-r2; %