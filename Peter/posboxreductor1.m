function [xcor2, ycor2] = posboxreductor1(topo, xcor, ycor, normdis)


q=1;
for i=1:length(xcor)
    clear dis disfur;
    for j=1:length(xcor)
        dis(j)=((xcor(i)-xcor(j))^2+(ycor(i)-ycor(j))^2)^0.5;
    end
        disfur=dis;
        [O1,R]=vortex_coherence_length(topo,0,360,10,round(xcor(i)),round(ycor(i)));
        
        [mini, minind1]=min(dis);
        dis(minind1)=max(dis);
        if mini(1) < (1.7*normdis)
            O2=vortex_coherence_length(topo,0,360,10,round(xcor(minind1)),round(ycor(minind1)));
            tbt=[mean(O1), mean(O2)];
            mininds=[1 , minind1];
        end
        
        [mini, minind2]=min(dis);
        dis(minind2)=max(dis);
        if mini(1) < (1.7*normdis)
            O3=vortex_coherence_length(topo,0,360,10,round(xcor(minind2)),round(ycor(minind2)));
            tbt=[tbt, mean(O3)];
            mininds=[mininds minind2];
        end
        
        [mini, minind3]=min(dis);
        dis(minind3)=max(dis);
        if mini(1) < (1.7*normdis)
            O4=vortex_coherence_length(topo,0,360,10,round(xcor(minind3)),round(ycor(minind3)));
            tbt=[tbt, mean(O4)];
            mininds=[mininds minind3];
        end
        
        [mini, minind4]=min(dis);
        if mini(1) < (1.7*normdis)
            O5=vortex_coherence_length(topo,0,360,10,round(xcor(minind4)),round(ycor(minind4)));
            tbt=[tbt, mean(O5)];
            mininds=[mininds minind4];
        end

%         figure, plot(R,O1,R,O2,R,O3,R,O4,R,O5);
        [maxi, maxind] = max(tbt);
 
        if maxind == 1
            xcor2(q)= xcor(i);
            ycor2(q)= ycor(i);
        else
            xcor2(q)= xcor(mininds(maxind));
            ycor2(q)= ycor(mininds(maxind));
        end
        q=q+1;
end

end












