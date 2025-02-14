function types = getPartitionTypeFromInternalType( internalType, options )









R36
internalType( :, 1 )string
options.IsExportFunction( 1, 1 )logical = false
end 

types = repmat( simulink.schedule.PartitionType.Unknown,  ...
size( internalType ) );

if options.IsExportFunction
explicitPeriodics =  ...
internalType == "explicit-periodic" |  ...
internalType == "implicit-periodic" |  ...
internalType == "base";
types( explicitPeriodics ) =  ...
simulink.schedule.PartitionType.ExportedPeriodic;

aperiodics =  ...
internalType == "aperiodic" |  ...
internalType == "aperiodic-async" |  ...
internalType == "async";
types( aperiodics ) = simulink.schedule.PartitionType.ExportedFunction;

types( internalType == "simulink-function" ) =  ...
simulink.schedule.PartitionType.SimulinkFunction;
else 
periodics =  ...
internalType == "base" |  ...
internalType == "implicit-periodic" |  ...
internalType == "explicit-periodic";
types( periodics ) = simulink.schedule.PartitionType.Periodic;

aperiodics =  ...
internalType == "aperiodic" |  ...
internalType == "aperiodic-async" |  ...
internalType == "simulink-function";
types( aperiodics ) = simulink.schedule.PartitionType.Aperiodic;

types( internalType == "async" ) =  ...
simulink.schedule.PartitionType.AsynchronousFunction;

end 







end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmpSmacs4.p.
% Please follow local copyright laws when handling this file.

