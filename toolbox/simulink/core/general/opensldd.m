function opensldd( name, namedArgs )




R36
name( 1, : )char
namedArgs.ForceUsingDAExplr( 1, 1 )logical = false
end 

try 

if ~namedArgs.ForceUsingDAExplr &&  ...
sl.interface.dict.api.isInterfaceDictionary( name )
dictObj = Simulink.interface.dictionary.open( name );
dictObj.show(  );
else 
dd1 = Simulink.dd.open( name, 'SubdictionaryErrorAction', 'warn' );
if dd1.isOpen
dd1.explore;
end 
end 
catch exception







load_system( 'simulink' );
Simulink.output.error( exception );
end 



% Decoded using De-pcode utility v1.2 from file /tmp/tmpHPOtUj.p.
% Please follow local copyright laws when handling this file.

