








function outputStructArray = getAssessmentStructArrayHelper( assessDataStruct, objID, fieldName )

R36
assessDataStruct
objID( 1, 1 )double
fieldName( 1, 1 )string{ mustBeMember( fieldName, [ "AssessmentsInfo", "MappingInfo" ] ) }
end 

assessmentsInfo = assessDataStruct.( fieldName );
assessmentGraph = stm.internal.assessments.createAssessmentGraph( assessmentsInfo );
structIDs = dfsearch( assessmentGraph, string( objID ) );
outputStructArray = [  ];
for i = 1:length( assessmentsInfo )
if ismember( string( assessmentsInfo{ i }.id ), structIDs )
outputStructArray = [ outputStructArray;assessmentsInfo( i ) ];
end 
end 

end 


% Decoded using De-pcode utility v1.2 from file /tmp/tmpR7R95K.p.
% Please follow local copyright laws when handling this file.

