function schema





    hCreateInPackage=findpackage('RTWinTarget');


    hDeriveFromPackage=findpackage('Simulink');
    hDeriveFromClass=findclass(hDeriveFromPackage,'ERTTargetCC');


    hThisClass=schema.class(hCreateInPackage,'RTWinTargetERTCC',hDeriveFromClass);




    hThisProp=schema.prop(hThisClass,'SLDRTDir','string');
    hThisProp.AccessFlags.Serialize='off';
    hThisProp.GetFunction=@(~,~)strrep(coder.make.internal.transformPaths(fileparts(fileparts(which('sldrtext')))),filesep,'/');

    hThisProp=schema.prop(hThisClass,'TargetArch','string');
    hThisProp.AccessFlags.Serialize='off';
    hThisProp.GetFunction=@(~,~)RTWinTarget.RTWinTargetCC.getTargetArch();


    hThisProp=add_prop(hThisClass,'CCListing','on/off');
    hThisProp.FactoryValue='off';

    hThisProp=add_prop(hThisClass,'RebuildAll','on/off');
    hThisProp.FactoryValue='off';

    hThisProp=add_prop(hThisClass,'ExtMode','on/off');
    hThisProp.FactoryValue='on';

    hThisProp=add_prop(hThisClass,'ExtModeTransport','slint');
    hThisProp.FactoryValue=0;

    hThisProp=add_prop(hThisClass,'ExtModeStaticAlloc','on/off');
    hThisProp.FactoryValue='off';

    hThisProp=add_prop(hThisClass,'ExtModeStaticAllocSize','slint');
    hThisProp.FactoryValue=1000000;

    hThisProp=add_prop(hThisClass,'ExtModeTesting','on/off');
    hThisProp.FactoryValue='off';

    hThisProp=add_prop(hThisClass,'ExtModeMexFile','ustring');
    hThisProp.FactoryValue='sldrtext';

    hThisProp=add_prop(hThisClass,'ExtModeMexArgs','ustring');
    hThisProp.FactoryValue='';

    hThisProp=add_prop(hThisClass,'ExtModeIntrfLevel','ustring');
    hThisProp.FactoryValue='Level1';

    hPreSetListener=handle.listener(hThisClass,hThisClass.Properties,'PropertyPreSet',...
    @preSetFcn_Prop);
    add_prop(hThisProp,'PreSetListener','handle');
    hThisProp.PreSetListener=hPreSetListener;


    m=schema.method(hThisClass,'getDialogSchema');
    s=m.Signature;
    s.varargin='off';
    s.InputTypes={'handle','string'};
    s.OutputTypes={'mxArray'};

    m=schema.method(hThisClass,'getStringFormat');
    s=m.Signature;
    s.varargin='off';
    s.InputTypes={'handle'};
    s.OutputTypes={'mxArray'};

    m=schema.method(hThisClass,'update');
    s=m.Signature;
    s.varargin='off';
    s.InputTypes={'handle','string'};
    s.OutputTypes={};

    m=schema.method(hThisClass,'getMdlRefComplianceTable');
    s=m.Signature;
    s.varargin='off';
    s.InputTypes={'handle','Sl_MdlRefTarget_EnumType'};
    s.OutputTypes={'MATLAB array'};






    function preSetFcn_Prop(hProp,eventData)


        hObj=eventData.AffectedObject;
        if~isequal(get(hObj,hProp.Name),eventData.NewVal)
            hObj.dirtyHostBD;
        end


        function p=add_prop(h,name,type)
            p=Simulink.TargetCCProperty(h,name,type);
            p.TargetCCPropertyAttributes.set_prop_attrib('CODEGEN_CODE');


