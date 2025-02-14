classdef ( Sealed, Hidden )ParametersSection < simscape.battery.internal.sscinterface.Section




properties ( Constant )
Type = "ParametersSection";
end 

properties ( Constant, Access = protected )
SectionIdentifier = "parameters"
end 

methods 
function obj = ParametersSection( attributeArguments )

R36
attributeArguments.Access string{ mustBeTextScalar, mustBeMember( attributeArguments.Access, [ "public", "private", "protected", "" ] ) } = ""
attributeArguments.ExternalAccess string{ mustBeTextScalar, mustBeMember( attributeArguments.ExternalAccess, [ "modify", "observe", "none", "" ] ) } = ""
end 
obj = obj.setAttribute( "Access", attributeArguments.Access );
obj = obj.setAttribute( "ExternalAccess", attributeArguments.ExternalAccess );
end 

function obj = addParameter( obj, name, value, label, unit )

R36
obj
name string{ mustBeTextScalar, mustBeNonzeroLengthText }
value string{ mustBeTextScalar, mustBeNonzeroLengthText }
label string{ mustBeTextScalar, mustBeNonzeroLengthText }
unit.Unit string{ mustBeTextScalar } = ""
end 



if unit.Unit ~= ""
definition = "{" + value + ",'" + unit.Unit + "'}";
else 
definition = value;
end 


obj.SectionContent( end  + 1 ) = simscape.battery.internal.sscinterface.EqualityStatement( name, definition, "Comment", label );
end 
end 
end 



% Decoded using De-pcode utility v1.2 from file /tmp/tmpOqJxhL.p.
% Please follow local copyright laws when handling this file.

