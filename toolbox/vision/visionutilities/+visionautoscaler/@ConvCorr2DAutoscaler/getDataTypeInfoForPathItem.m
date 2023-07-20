function[maskSignValStr,wlValueStr,flValueStr,specifiedDTStr,flDlgStr,...
    modeDlgStr,wlDlgStr]=getDataTypeInfoForPathItem(h,blkObj,pathItem)




    fixdtSignValStr='1';
    maskSignValStr='Signed';


    switch pathItem
    case 'Product output'
        paramPrefixStr='prodOutput';





        fixdtSignValStr=getInportFixdtSignValStr(h,blkObj,[1,2]);
        maskSignValStr=fixdtSignValStr2maskSignValStr(h,fixdtSignValStr);

    case 'Accumulator'
        paramPrefixStr='accum';





        fixdtSignValStr=getInportFixdtSignValStr(h,blkObj,[1,2]);
        maskSignValStr=fixdtSignValStr2maskSignValStr(h,fixdtSignValStr);

    case 'Output'

        paramPrefixStr='output';


        fixdtSignValStr=getInportFixdtSignValStr(h,blkObj,1);
        maskSignValStr=fixdtSignValStr2maskSignValStr(h,fixdtSignValStr);
    otherwise

    end

    [wlValueStr,flValueStr,specifiedDTStr,flDlgStr,modeDlgStr,wlDlgStr]=...
    getDTypeInfoForPathItem(h,blkObj,paramPrefixStr,fixdtSignValStr);


