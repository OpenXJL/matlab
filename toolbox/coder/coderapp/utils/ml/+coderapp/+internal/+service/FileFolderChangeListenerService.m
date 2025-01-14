classdef ( Sealed )FileFolderChangeListenerService < coderapp.internal.service.EventListenerService





methods 
function this = FileFolderChangeListenerService( mfzModel )

R36
mfzModel( 1, 1 )mf.zero.Model = mf.zero.Model(  )
end 
this = this@coderapp.internal.service.EventListenerService( mfzModel );
end 
end 

methods ( Access = protected )
function eventListener = createEventListener( this, opts )





R36
this( 1, 1 )
opts.fileOrFolderPath{ mustBeValidFileOrFolderPath( opts.fileOrFolderPath ) }
opts.recursive( 1, 1 )logical = false
opts.callback{ mustBeValidEventListenerCallback( opts.callback, numArgsIn = 1 ) }
end 
fileOrFolderPath = opts.fileOrFolderPath;
eventListener = coderapp.internal.event.FileFolderChangeEventListener( this.MfzModel );
eventListener.FileOrFolderPath = fileOrFolderPath;
eventListener.IsFolder = isfolder( fileOrFolderPath );
if isfolder( fileOrFolderPath )
eventListener.EnableRecursiveTrackingForFolders = opts.recursive;
end 
eventListener.Callback = opts.callback;
end 
end 
end 

function mustBeValidFileOrFolderPath( fileOrFolderPath )

R36
fileOrFolderPath{ mustBeNonempty( fileOrFolderPath ), mustBeTextScalar( fileOrFolderPath ) }
end 
if ~isfile( fileOrFolderPath ) && ~isfolder( fileOrFolderPath )
throwAsCaller( MException( message( "coderApp:services:fileOrFolderPathNotFound", fileOrFolderPath ) ) );
end 
end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmp4c0u76.p.
% Please follow local copyright laws when handling this file.

