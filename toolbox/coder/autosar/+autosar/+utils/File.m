classdef File < handle




methods ( Static )
function filesOut = dropPath( filesIn, namedargs )
R36
filesIn
namedargs.DropExtension = false;
end 

if iscell( filesIn )
filesOut = cellfun( @( x )autosar.utils.File.dropPathSingleFile( x, namedargs.DropExtension ), filesIn,  ...
'UniformOutput', false );
else 
filesOut = autosar.utils.File.dropPathSingleFile( filesIn, namedargs.DropExtension );
end 
end 
end 

methods ( Static, Access = private )
function fileOut = dropPathSingleFile( fileIn, dropExtension )
[ ~, n, e ] = fileparts( fileIn );
if dropExtension
fileOut = n;
else 
fileOut = [ n, e ];
end 
end 
end 
end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmpNGWZGv.p.
% Please follow local copyright laws when handling this file.

