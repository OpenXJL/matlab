function [ success, output ] = createEvolution( treeId, evolutionName )

R36
treeId( 1, : )char
evolutionName( 1, : )char
end 

tree = evolutions.internal.getDataObject( treeId );
[ success, output ] = evolutions.internal.createEvolution( tree, evolutionName );

end 

