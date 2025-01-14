classdef View2D < rfpcb.internal.apps.transmissionLineDesigner.view.Document




properties 
View2DModel
end 

methods 

function obj = View2D( View2DModel )

R36
View2DModel( 1, 1 )rfpcb.internal.apps.transmissionLineDesigner.model.View2DModel{ mustBeNonempty } = rfpcb.internal.apps.transmissionLineDesigner.model.View2DModel;
end 
obj.View2DModel = View2DModel;
obj.DocumentGroupTag = 'visualizationGroup';

obj.Tag = 'view2dDocument';
obj.Title = getString( message( "rfpcb:transmissionlinedesigner:View2DDocument" ) );
obj.Tile = 1;

debug( obj.View2DModel.Logger, 'View2DDocument = matlab.ui.internal.FigureDocument("Tag", "view2dDocument", "DocumentGroupTag", "visualizationGroup");' );
end 


function produce( obj )

R36
obj( 1, 1 )rfpcb.internal.apps.transmissionLineDesigner.view.View2D
end 

end 
end 
end 



% Decoded using De-pcode utility v1.2 from file /tmp/tmp77NSuN.p.
% Please follow local copyright laws when handling this file.

