function viewer = createUnsavedFilesWarningDialog( project )




R36
project( 1, 1 ) = currentProject(  );
end 

provider = matlab.internal.project.unsavedchanges.TrackingLoadedFileProvider;
filter = @( files )matlab.internal.project.unsavedchanges.filter.unsavedProjectFiles( files, project );

viewer = matlab.internal.project.unsavedchanges.ui.LoadedFileViewer(  ...
provider,  ...
filter,  ...
"CancelButtonText", "MATLAB:project:view_unsaved_changes:Cancel",  ...
"AutoCloseUI", true );

addlistener( viewer, "Close", @( ~, ~ )delete( viewer ) );
end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmpid4His.p.
% Please follow local copyright laws when handling this file.
