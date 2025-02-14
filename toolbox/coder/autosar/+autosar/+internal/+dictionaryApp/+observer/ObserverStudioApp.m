classdef ObserverStudioApp < autosar.mm.observer.Observer




properties ( SetAccess = immutable, GetAccess = private )
StudioApp;
end 

methods 
function this = ObserverStudioApp( studioApp )
assert( ~isempty( studioApp ), 'StudioApp should not be empty!' );
this.StudioApp = studioApp;
end 

function observeChanges( this, changesReport )

R36
this autosar.internal.dictionaryApp.observer.ObserverStudioApp
changesReport M3I.ReportOfChanges
end 
this.StudioApp.refreshList( changesReport );
end 
end 
end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmpOJzWNo.p.
% Please follow local copyright laws when handling this file.

