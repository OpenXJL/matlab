classdef Adaptation < handle




properties 
Adapter;
ModeEnum;
end 
properties ( Access = private )
Mode;
ConversionOptions;
end 
methods 
function this = Adaptation( adapter )

R36
adapter( 1, 1 )double;
end 
this.Adapter = adapter;
this.ModeEnum = systemcomposer.internal.adapter.ModeEnums;
[ this.Mode, this.ConversionOptions ] = systemcomposer.internal.adapter.getAdapterMode( adapter );
end 
function setMode( this, mode )

R36
this;
mode( 1, : )char;
end 
this.Mode = mode;
if strcmpi( mode, this.ModeEnum.RateTransition )
this.ConversionOptions( 'Integrity' ) = true;%#ok<*MCSUP> 
this.ConversionOptions( 'Deterministic' ) = false;
this.ConversionOptions( 'InitialConditions' ) = '0';
end 
end 
function mode = getMode( this )
mode = this.Mode;
end 
function val = getConversionOptionValue( this, key )
R36
this
key( 1, : )char
end 
val = this.ConversionOptions( key );
end 
function setConversionOptionValue( this, key, newVal )

R36
this
key( 1, : )char
newVal( 1, : )
end 
this.ConversionOptions( key ) = newVal;
end 
function tf = isMode( this, mode )

R36
this
mode( 1, : )char
end 
tf = strcmp( this.Mode, mode );
end 
function save( this )

systemcomposer.internal.adapter.setAdapterMode( this.Adapter, this.Mode, this.ConversionOptions );
end 
function supportedModes = getSupportedModes( this )

supportedModes = systemcomposer.internal.adapter.getSupportedAdapterModes( this.Adapter );
end 
end 
end 
% Decoded using De-pcode utility v1.2 from file /tmp/tmp0NATqT.p.
% Please follow local copyright laws when handling this file.

