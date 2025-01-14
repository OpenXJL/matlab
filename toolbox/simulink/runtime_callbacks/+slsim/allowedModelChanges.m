function modelMutability = allowedModelChanges( modelName )











R36
modelName( 1, 1 )string
end 


if ( ~strcmp( get_param( modelName, 'type' ), 'block_diagram' ) )
msgId = 'SimulinkExecution:SimulationService:InvalidModelHandle';
me = MException( msgId, message( msgId, modelName ).getString(  ) );
throwAsCaller( me );
end 

isDeployed = ismcc || isdeployed;
if isDeployed
simStatus = slsim.internal.getSimulationStatus( modelName );
else 
simMode = get_param( modelName, 'SimulationMode' );
isRaccel = strcmp( simMode, 'rapid-accelerator' );
if isRaccel
simStatus = slsim.internal.getSimulationStatus( modelName );
else 
simStatus = get_param( modelName, 'SimulationStatus' );
end 
end 
modelMutability = slsim.internal.getModelMutabilityLevel( simStatus, isDeployed );
end 
% Decoded using De-pcode utility v1.2 from file /tmp/tmpQg_Wi2.p.
% Please follow local copyright laws when handling this file.

