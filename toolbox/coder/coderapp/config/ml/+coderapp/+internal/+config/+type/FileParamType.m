classdef ( Sealed )FileParamType < coderapp.internal.config.type.AbstractFileParamType



methods 
function this = FileParamType(  )
this@coderapp.internal.config.type.AbstractFileParamType(  ...
'file', 'coderapp.internal.config.data.FileParamData' );
end 

function value = validate( this, value, dataObj )
R36
this
value
dataObj = [  ]
end 
value = this.validateFile( value, dataObj );
end 
end 

methods ( Access = protected )
function imported = importValue( this, value )
imported = this.validateFile( value );
end 

function value = exportValue( ~, value )
end 

function value = valueFromSchema( this, value )
value = this.validateFile( value );
end 
end 
end 


% Decoded using De-pcode utility v1.2 from file /tmp/tmpGYQOUe.p.
% Please follow local copyright laws when handling this file.

