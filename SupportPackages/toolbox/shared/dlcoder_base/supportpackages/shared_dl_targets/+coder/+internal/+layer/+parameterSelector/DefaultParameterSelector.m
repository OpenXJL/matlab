classdef DefaultParameterSelector < coder.internal.layer.parameterSelector.BaseParameterSelector






























properties 

MatrixMultiplicationParameters( 1, 1 )coder.internal.layer.matrixMultiplication.CgirBaseParameters =  ...
coder.internal.layer.matrixMultiplication.CgirCpuParameters( 'SimdRegistersPerColumn', 2,  ...
'RegisterBlockWidth', 2,  ...
'CacheBlockSizeM', 128,  ...
'CacheBlockSizeK', 128,  ...
'CacheBlockSizeN', 128,  ...
'UsePackingA', false,  ...
'UsePackingB', false )


ConvolutionParameters( 1, 1 )coder.internal.layer.convUtils.CgirBaseParameters =  ...
coder.internal.layer.convUtils.CgirCpuParameters(  )
end 

methods 

function obj = DefaultParameterSelector( nvps )
R36
nvps.MatrixMultiplicationParameters
nvps.ConvolutionParameters
end 

obj = dltargets.internal.assignNVPsToClassObject( obj, nvps );
end 

function params = selectMatrixMultiplicationParameters( obj, specification, buildContext )






R36
obj( 1, 1 )
specification coder.internal.layer.matrixMultiplication.OperationSpecification{ mustBeScalarOrEmpty }%#ok
buildContext{ mustBeScalarOrEmpty }%#ok                


end 


params = obj.MatrixMultiplicationParameters;
end 

function params = selectConvolutionParameters( obj, specification, buildContext )





R36
obj( 1, 1 )
specification coder.internal.layer.convUtils.OperationSpecification{ mustBeScalarOrEmpty }%#ok
buildContext{ mustBeScalarOrEmpty }%#ok                                

end 

params = obj.ConvolutionParameters;
end 

end 

end 

% Decoded using De-pcode utility v1.2 from file /tmp/tmpwqWizY.p.
% Please follow local copyright laws when handling this file.

