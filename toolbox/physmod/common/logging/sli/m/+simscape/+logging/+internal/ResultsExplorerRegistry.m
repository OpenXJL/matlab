classdef ( Sealed )ResultsExplorerRegistry < handle





properties 
Instances( 1, : )simscape.logging.internal.ResultsExplorerController
end 

methods 
function inst = get.Instances( obj )

inst = obj.Instances;
invalid = ~isvalid( inst );
inst( invalid ) = [  ];
obj.Instances = inst;
end 
end 

methods ( Access = private )
function obj = ResultsExplorerRegistry(  )
end 
end 
methods ( Static, Access = ?hResultsExplorerRegistryTester )
function obj = manager(  )
import simscape.logging.internal.ResultsExplorerRegistry
mlock(  );
persistent Manager
if isempty( Manager )
Manager = ResultsExplorerRegistry(  );
end 
obj = Manager;
end 
end 
methods ( Static, Access = ?simscape.logging.internal.ResultsExplorerController )


function register( obj )
R36
obj( 1, 1 )simscape.logging.internal.ResultsExplorerController
end 
import simscape.logging.internal.ResultsExplorerRegistry
mng = ResultsExplorerRegistry.manager(  );
if ~any( obj == mng.Instances )
mng.Instances = [ mng.Instances, obj ];
end 
end 



function unregister( obj )
R36
obj( 1, 1 )simscape.logging.internal.ResultsExplorerController
end 
import simscape.logging.internal.ResultsExplorerRegistry


mng = ResultsExplorerRegistry.manager(  );
isObj = obj == mng.Instances;
mng.Instances( isObj ) = [  ];
end 

end 
end 
% Decoded using De-pcode utility v1.2 from file /tmp/tmptJh1J0.p.
% Please follow local copyright laws when handling this file.

