%Yi Xue chong, 8 Nov 2017
%vargain input function example

function [output1,output2] = varagin_guide(dummy,varargin)

if nargin == 0
    output1 = 'empty';
    output2 = 'shithead';
elseif nargin ==1
    output1 = dummy;
    output2 = 'shithead';
    
else
    output1 = varargin{1};
    output2 = varargin{2};
end
end
