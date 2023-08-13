function varargout = getGlobalParamChecksum ...
( lModelName, lModelReferenceTargetType, varList, inlineParameters,  ...
ignoreCSCs, designDataLocation, toPerformCleanup,  ...
computeIndividualVarChecksums, enableAccessToBaseWorkspace )





if slfeature( 'SLModelAllowedBaseWorkspaceAccess' ) > 0
[ varargout{ 1:nargout } ] = slprivate( 'get_modelref_global_variable_checksum',  ...
lModelName,  ...
lModelReferenceTargetType,  ...
varList,  ...
inlineParameters,  ...
ignoreCSCs,  ...
designDataLocation,  ...
toPerformCleanup,  ...
computeIndividualVarChecksums,  ...
enableAccessToBaseWorkspace );
else 
[ varargout{ 1:nargout } ] = slprivate( 'get_modelref_global_variable_checksum',  ...
lModelName,  ...
lModelReferenceTargetType,  ...
varList,  ...
inlineParameters,  ...
ignoreCSCs,  ...
designDataLocation,  ...
toPerformCleanup,  ...
computeIndividualVarChecksums );
end 
end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmp8IvYS_.p.
% Please follow local copyright laws when handling this file.
