function retVal=feature(varargin)








    narginchk(1,2);

    mlock;
    persistent featureMap;

    if isempty(featureMap)
        featureMap=containers.Map("KeyType","char","ValueType","char");

        featureMap("OversizedCaptureSupport")="off";

    end

    featureName=varargin{1};


    retVal=[];
    if featureMap.isKey(featureName)
        retVal=featureMap(featureName);
    end

    if nargin==2

        featureValue=varargin{2};


        featureMap(featureName)=featureValue;
    end



end
