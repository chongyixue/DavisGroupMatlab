function [P,R]=findpeaks_3_edit(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup)
%2018-10-4 added R to see error of fit

% Function to locate the positive peaks in a noisy x-y data
% set.  Detects peaks by looking for downward zero-crossings
% in the first derivative that exceed SlopeThreshold.
% Returns list (P) containing peak number and
% position, height, and width of each peak. SlopeThreshold,
% AmpThreshold, and smoothwidth control sensitivity
% Higher values will neglect smaller features. Peakgroup
% is the number of points around the "top part" of the peak.
smoothwidth=round(smoothwidth);
peakgroup=round(peakgroup);
d=fastsmooth(deriv(y),smoothwidth);
%d=-fastsmooth(deriv(d1),smoothwidth);
%d=fastsmooth(deriv(d2),smoothwidth);
n=round(peakgroup/2+1);
P=[0 0 0];
vectorlength=length(y);
peak=1;
AmpTest=AmpThreshold;
R=0;
for j=smoothwidth:length(y)-smoothwidth,
   if sign(d(j)) > sign (d(j+1)), % Detects zero-crossing
     if d(j)-d(j+1) > SlopeThreshold*y(j), % if slope of derivative is larger than SlopeThreshold
        if y(j) > AmpTest,  % if height of peak is larger than AmpThreshold
          for k=1:peakgroup, % Create sub-group of points near peak
              groupindex=j+k-n+2;
              if groupindex<1, 
                  groupindex=1;
              end
              if groupindex>vectorlength, 
                  groupindex=vectorlength;
              end
            xx(k)=x(groupindex);yy(k)=y(groupindex);
          end    
          [coef]=polyfit(xx,((yy)),2);  % Fit parabola to log10 of sub-group         
          diffr = mean(diff(xx));          
          x_fine = xx(1):diffr/20:xx(end); 
%           length(x_fine)
          f = polyval(coef,x_fine);
          f2 = polyval(coef,xx);
          avg = sum(yy)/length(xx);
          SS_reg = sum((f2-avg).^2);
          SS_tot = sum((avg-yy).^2);
          R = 1-SS_reg/SS_tot;
          %figure; plot(xx,yy,'b'); hold on; plot(x_fine,f,'r');
          PeakX = mean(x_fine(f == max(f))); % Compute peak position and height of fitted parabola
          PeakY = max(max(f));       
          
          %figure; plot(x,y,'bx'); hold on; plot(x_fine,f,'r'); 
          
          
          % Construct matrix P. One row for each peak 
          % detected, containing the peak number, peak 
          % position (x-value) and peak height (y-value).
          P(peak,:) = [round(peak) PeakX PeakY];
          peak=peak+1;
        end
      end
   end
end