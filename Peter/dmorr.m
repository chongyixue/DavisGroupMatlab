function cmap = dmorr(n);

% TERRAIN   TerrainColormap  [ R  G  B ]
%            
%           DarkCyan --> LightCyan / Green --> Brown
%
% Palette = TERRAIN(N)  returns N Colors
%          
%  Note:  N is automaticly set to an EVEN Number
%
% see also: TERRA, TERRAING
%

cmap = [ ...
   0.      0.  0.  40.
  20.     20.  60.  100.
  50.      0. 40. 0.
  75.     100.  100.   0.
  85.     100.  50.   0.
 100.     100.  0.  0. ];

if nargin == 0

   fig = get( 0 , 'currentfigure' );

   if isempty(fig)
      c = get( 0 , 'defaultfigurecolormap' );
   else
      c = get( fig , 'colormap' );
   end
  
   n = size(c,1);

else

  ok = ( isnumeric(n)  &  ( prod(size(n)) == 1 ) );
  if ok
     ok = ( ( n >= 0 ) & ( mod(n,1) == 0 ) );
  end

  if ~ok
      error('ColorNumber must be a positive Integer.');
  elseif ( n == 0 )
      cmap = zeros(0,3);
      return
  end

end

n = 2*ceil(n/2);

c = linspace(cmap(1,1),cmap(end,1),n)';

cmap = interp1( cmap(:,1) , cmap(:,[2 3 4]) , c ) / 100;


