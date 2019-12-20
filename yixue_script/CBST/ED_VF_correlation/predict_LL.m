% 2019-10-6 YXC

function [llmappredict,llmapDIFF,llmapshow] = predict_LL(llmapnonstruct,map,zeroLLnumber,EDmethod,Delmethod,VFlowermethod,VFhighermethod)

[llmapshow,Del,~,~,~] = ED_KF_corr_function(llmapnonstruct,map,zeroLLnumber,Delmethod);
[~,~,VF_lower,~,~] = ED_KF_corr_function(llmapnonstruct,map,zeroLLnumber,VFlowermethod);
[~,~,~,VF_higher,~] = ED_KF_corr_function(llmapnonstruct,map,zeroLLnumber,VFhighermethod);
[~,~,~,~,Ed] = ED_KF_corr_function(llmapnonstruct,map,zeroLLnumber,EDmethod);

[~,~,nLL] = size(llmapnonstruct);

LL = zeros(size(llmapnonstruct));

DEL = Del.map;
VFL = VF_lower.map;
VFH = VF_higher.map;
ED = Ed.map;

for i = 1:nLL
   if i<zeroLLnumber
       LL(:,:,i) = ED-sqrt(DEL.^2+abs(i-zeroLLnumber)*VFL.^2);
   elseif i>zeroLLnumber
       LL(:,:,i) = ED+sqrt(DEL.^2+abs(i-zeroLLnumber)*VFH.^2);
   else
       LL(:,:,i) = ED + DEL;
   end
end
llmappredict = llmapshow;
llmappredict.map = LL;
llmappredict.name = strcat(llmappredict.name,'_predict');
llmapDIFF = llmapshow;
llmapDIFF.map = llmapshow.map-llmappredict.map;
llmapDIFF.name = strcat(llmapshow.name,'_DIFF');

% [~,Del,VF_lower,VF_higher,Ed] = ED_KF_corr_function(llmap,map,zeroLLnumber,method)


end
