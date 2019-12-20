function svdM = SVDSTM(data,varargin)
%function svdM = SVDSTM(data,varargin)
%
%Generation of component maps from STM data using Singular Value 
%Decomposition (SVD) analysis with reference spectra
%P.O. Sprau 05/23/14. (based on code for STXM)
%
%Inputs
%------
%data       Standard structure array containing the STM data 
%          
%varargin   arbitrary number of two-column vectors representing the 
%           component's reference spectra. The first column of the
%           reference spectra vectors contains the energy points (in meV), 
%           the second column holds the corresponding LDOS.
%
%Output
%------
%svdM       m x n x k array containing the component maps. (m, n correspond
%           to the number of stack pixels in y and x dimension, k is 
%           determined by the number of component reference spectra passed 
%           to the script as varargin. svdM(:,:,i) contains the component 
%           map corresponding to the ith reference spectrum in varargin 



% varargin contains the reference data for the # (nofcps) of components cps
cps=varargin{1}; 

% determine number of components:
nofcps=length(cps);

SeVmin=min(data.e);
SeVmax=max(data.e);

% determin energy range of reference spectra
cpseVmin=min(cps{1}(:,1));
cpseVmax=max(cps{1}(:,1));

for k=2:nofcps
    
    if min(cps{k}(:,1)) > cpseVmin
        cpseVmin=min(cps{k}(:,1));
    end
    
    if max(cps{k}(:,1)) < cpseVmax
        cpseVmax=max(cps{k}(:,1));
    end
    
end

% truncate experimental data if reference spectra energy range is smaller 
% than experimental data
if cpseVmin > SeVmin
    
    fstidx=find(data.e < cpseVmin,1,'first');
    lstidx=find(data.e < cpseVmin,1,'last');
    % remove experimental data that is out of reference spectra data range
    data.e(fstidx:lstidx)=[];
    data.map(:,:,fstidx:lstidx)=[];
    
end

if cpseVmax < SeVmax
    
    fstidx=find(data.e > cpseVmax,1,'first');
    lstidx=find(data.e > cpseVmax,1,'last');
    
    % remove experimental data that is out of reference spectra data range
    data.e(fstidx:lstidx)=[];
    data.map(:,:,fstidx:lstidx)=[];
    
end

% construction of the reference components coefficient matrix

M=zeros(length(data.e),nofcps);

for k=1:nofcps
    
    M(:,k)=spline(cps{k}(:,1),cps{k}(:,2),data.e);
    
end

%construction of the coefficient matrix pseudo inverse using SVD
pseudoInvM=pinv(M);

svdM=zeros(size(data.map,1),size(data.map,2),nofcps);

for y=1:size(data.map,1)
    for x=1:size(data.map,2)
        temp(:,1)=data.map(y,x,:);
        svdM(y,x,:)=pseudoInvM*temp;
    end
end

% plotSvdRgb(svdM,S)

return