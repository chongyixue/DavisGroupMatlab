% Author:
% Anchal Gupta
% Graduate Student at California Institute of Technology
% Function Description:
% This script simulates Conway's game of life on a NxN toroid of cells for
% a time t.
% Declaration:
% I allow all modifications and distribution of this code, including deleting
% this text itself.

function []=combIm(TPM,filename,fns,GridSize)
% Combines Images in grid structure with trimming.
% Description:
% If you have a set of figures (same size) which you need to combine 
% together and also get want to get rid of extra white space around the 
% image which makes relevant part smaller, this is the function for you.
% Input:
% TPM:      Number of pixels to keep on margin while trimming. Make zero 
%           for no trimming. (default 10, can be changed in GUI)
% filename: Filename to be given to combined file. Give less than 3 inputs
%           if you want to use gui for selecting files.
% fns:      Cell array containing names of the image files to read. Give 
%           less than 3 inputs if you want to use gui for selecting files.
% Output:
% No output to workspace. Will save combined image in current folder.
%
% Note: If you want to just trim a file, you can giveonly one input file.

if nargin<3
    fns=uigetfile('*.*','Select the images in the order of combination','MultiSelect', 'on');
    if nargin<1
        prompt = {'Enter the number of pixels to keep at margin while trimming'};
        dlg_title = 'Enter the number of pixels to keep at margin while trimming';
        num_lines = 1;
        defaultans = {'10'};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans,'on');
        TPM=str2num(cell2mat(answer(1)));
    end
end
nof = size(fns,2);
for i=1:1:nof
    Images(i,:,:,:) = imread(char(fns(i)));
end

%Trimming the images
colsum=765*size(Images,3)*nof;
i=0;
while colsum==765*size(Images,3)*nof
    i=i+1;
    colsum = sum(reshape(Images(:,i,:,:),1,nof*size(Images,3)*3));
end
Images = Images(:,max(1,i-TPM):end,:,:);
colsum=765*size(Images,3)*nof;
i=size(Images,2);
while colsum==765*size(Images,3)*nof
    i=i-1;
    colsum = sum(reshape(Images(:,i,:,:),1,nof*size(Images,3)*3));
end
Images = Images(:,1:min(i+TPM,size(Images,2)),:,:);

rowsum=765*size(Images,2)*nof;
i=0;
while rowsum==765*size(Images,2)*nof
    i=i+1;
    rowsum = sum(reshape(Images(:,:,i,:),1,nof*size(Images,2)*3));
end
Images = Images(:,:,max(1,i-TPM):end,:);
rowsum=765*size(Images,2)*nof;
i=size(Images,3);
while rowsum==765*size(Images,2)*nof
    i=i-1;
    rowsum = sum(reshape(Images(:,:,i,:),1,nof*size(Images,2)*3));
end
Images = Images(:,:,1:min(i+TPM,size(Images,3)),:);
%Trimming over

%Combining images
if nargin<4
    prompt = {'Enter number of rows M:','Enter number of columns N:'};
    dlg_title = 'Enter the grid size of combined image';
    num_lines = 1;
    defaultans = {num2str(nof),'1'};
    M=1;N=1;
    while M*N ~= nof
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans,'on');
        M=str2num(cell2mat(answer(1)));
        N=str2num(cell2mat(answer(2)));
        if  M*N ~= nof
            mes = sprintf(strcat('Error in last input: MxN (',num2str(M),'x',num2str(N),') is not same as number of images uploaded (',num2str(nof),')'));
            uiwait(msgbox(mes));
        end
    end
else
    M = GridSize(1);
    N = GridSize(2);
end

Combined = reshape(Images(1,:,:,:),size(Images,2),size(Images,3),size(Images,4));
for j=2:1:N
    Combined = horzcat(Combined,reshape(Images(j,:,:,:),size(Images,2),size(Images,3),size(Images,4)));
end
for i=2:1:M
    Hcombined = reshape(Images((i-1)*N + 1,:,:,:),size(Images,2),size(Images,3),size(Images,4));
    for j=2:1:N
        Hcombined = horzcat(Hcombined,reshape(Images((i-1)*N + j,:,:,:),size(Images,2),size(Images,3),size(Images,4)));
    end
    Combined = vertcat(Combined,Hcombined);
end
%Combining over

%Writing combined file
if nargin<2
    prompt = {'Enter combined filename with extension'};
    dlg_title = 'Enter combined filename with extension';
    num_lines = 1;
    defaultans = {'combined.png'};
    answer2 = inputdlg(prompt,dlg_title,num_lines,defaultans,'on');
    filename = cell2mat(answer2(1));
end
imwrite(Combined,filename);
end