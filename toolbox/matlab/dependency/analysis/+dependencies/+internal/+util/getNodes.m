function nodes = getNodes( input, extensions )








R36
input
extensions( 1, : )string = dependencies.internal.Registry.Instance.getAnalysisExtensions(  );
end 

if isa( input, 'matlab.project.Project' ) || isa( input, 'matlab.internal.project.api.Project' ) || isa( input, 'slproject.ProjectManager' )
nodes = dependencies.internal.util.getProjectNodes( input, extensions );
elseif isa( input, 'function_handle' )
nodes = dependencies.internal.util.getFunctionHandleNodes( input );
elseif isa( input, 'dependencies.internal.graph.Node' )
nodes = input;
else 
nodes = dependencies.internal.util.getFileNodes( input, extensions );
end 

end 


% Decoded using De-pcode utility v1.2 from file /tmp/tmptLaoYh.p.
% Please follow local copyright laws when handling this file.

