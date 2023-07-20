function DataPoints=computeTire(tireDataSrc,varargin)





    defaultBltSpeed=zeros(1,numel(tireDataSrc));
    defaultInflPress=zeros(1,numel(tireDataSrc));
    defaultFz_load=zeros(1,numel(tireDataSrc));

    for tt=1:numel(tireDataSrc)
        defaultBltSpeed(tt)=tireDataSrc(tt).LONGVL;
        defaultInflPress(tt)=tireDataSrc(tt).NOMPRES;
        defaultFz_load(tt)=tireDataSrc(tt).FNOMIN;
    end

    p=inputParser;
    validSpeed=@(x)isnumeric(x)&~any(x<=0);
    validPress=@(x)isnumeric(x)&~any(x<=0);
    validLoad=@(x)isnumeric(x)&~any(x<=0);
    validCamber=@(x)isnumeric(x)&~any(abs(x)>10*pi/180);
    validString=@(x)strcmpi(x,"on")|strcmpi(x,"off");
    addRequired(p,"tireDataSrc");
    addParameter(p,"beltSpeed",defaultBltSpeed,validSpeed);
    addParameter(p,"pressure",defaultInflPress,validPress);
    addParameter(p,"load",defaultFz_load,validLoad);
    addParameter(p,"camber",0,validCamber);
    addParameter(p,"plySteer","on",validString);
    addParameter(p,"turnSlip","off",validString);
    parse(p,tireDataSrc,varargin{:});


    if~isa(tireDataSrc,'tire.tire')
        error("Enter a valid object of 'tire.tire' class");
    end


    len=unique([numel(tireDataSrc),numel(p.Results.pressure),numel(p.Results.load),numel(p.Results.beltSpeed),numel(p.Results.camber),numel(p.Results.plySteer),numel(p.Results.turnSlip)]);
    if(~any(ismember(len,1))&&length(len)>1)||length(len)>2
        error("Incompatible size of input parameter");
    else
        rp=max(len);
    end

    if numel(tireDataSrc)==1&&rp>1
        tireDataSrc=repelem(tireDataSrc,rp);
    end


    dim=560;
    ColName=strings(1,rp);
    Fx=zeros(dim,rp);
    Fy=zeros(dim,rp);
    Fz=zeros(dim,rp);
    Mx=zeros(dim,rp);
    My=zeros(dim,rp);
    Mz=zeros(dim,rp);
    Alpha=zeros(dim,rp);
    Kappa=zeros(dim,rp);

    pressArray=p.Results.pressure.*ones(1,rp);
    loadArray=p.Results.load.*ones(1,rp);
    camberArray=p.Results.camber.*ones(1,rp);
    speedArray=p.Results.beltSpeed.*ones(1,rp);

    if strcmpi(p.Results.plySteer,"on")
        plyStrArray=ones(1,rp);
    else
        plyStrArray=zeros(1,rp);
    end

    if strcmpi(p.Results.turnSlip,"on")
        turnSlipArray=ones(1,rp);
    else
        turnSlipArray=zeros(1,rp);
    end


    test=["longitudinal","lateral"];

    for sweep=1:2
        testType=test(sweep);
        count=1;
        for jj=1:rp


            [Fx(1:dim,count),Fy(1:dim,count),Fz(1:dim,count),Mx(1:dim,count),My(1:dim,count),Mz(1:dim,count),Alpha(1:dim,count),Kappa(1:dim,count)]=vdyncsmtireinput(dim,tireDataSrc(jj),testType,speedArray(jj),pressArray(jj),loadArray(jj),camberArray(jj),plyStrArray(jj),turnSlipArray(jj));

            ColName(1,count)=matlab.lang.makeValidName(string(tireDataSrc(jj).NAME)+'_'+string(pressArray(jj))+'Pa_'+string(speedArray(jj))+'m_s_'+string(loadArray(jj))+'N_'+string(camberArray(jj)*180/pi)+'deg_'+string(plyStrArray(jj))+'_PlySteer_'+string(turnSlipArray(jj))+'_TurnSlip');
            count=count+1;
        end
        switch testType
        case "longitudinal"

            DataPoints.Long.Fx=array2table(Fx,'VariableNames',ColName);
            DataPoints.Long.Fy=array2table(Fy,'VariableNames',ColName);
            DataPoints.Long.Fz=array2table(Fz,'VariableNames',ColName);
            DataPoints.Long.Mx=array2table(Mx,'VariableNames',ColName);
            DataPoints.Long.My=array2table(My,'VariableNames',ColName);
            DataPoints.Long.Mz=array2table(Mz,'VariableNames',ColName);
            DataPoints.Long.Alpha=array2table(Alpha,'VariableNames',ColName);
            DataPoints.Long.Kappa=array2table(Kappa,'VariableNames',ColName);
        case "lateral"

            DataPoints.Lat.Fx=array2table(Fx,'VariableNames',ColName);
            DataPoints.Lat.Fy=array2table(Fy,'VariableNames',ColName);
            DataPoints.Lat.Fz=array2table(Fz,'VariableNames',ColName);
            DataPoints.Lat.Mx=array2table(Mx,'VariableNames',ColName);
            DataPoints.Lat.My=array2table(My,'VariableNames',ColName);
            DataPoints.Lat.Mz=array2table(Mz,'VariableNames',ColName);
            DataPoints.Lat.Alpha=array2table(Alpha,'VariableNames',ColName);
            DataPoints.Lat.Kappa=array2table(Kappa,'VariableNames',ColName);
        end
    end
    function[Fx,Fy,Fz,Mx,My,Mz,alpha,kappa]=vdyncsmtireinput(dim,tr,testType,WhlSpeed,InflPress,Fz_load,gamma,plystr,turnslip)


        tr.KPUMAX=1;
        tr.KPUMIN=-1;
        tr.ALPMAX=90*pi/180;
        tr.ALPMIN=-90*pi/180;



        Ops.dim=dim;

        Ops.Vx=WhlSpeed*ones(Ops.dim,1);


        Ops.scaleFactors=ones(27,Ops.dim);
        Ops.scaleFactors(4,:)=zeros(1,Ops.dim);


        Ops.vdynMF=ones(4);
        Ops.psidot=0;


        Ops.Fx_ext=zeros(Ops.dim,1);
        Ops.Fy_ext=zeros(Ops.dim,1);

        switch lower(testType)
        case "longitudinal"








            omega_hi=2*unique(Ops.Vx)/tr.UNLOADED_RADIUS;
            omega_ihi=1.2*unique(Ops.Vx)/tr.UNLOADED_RADIUS;
            omega_ilo=0.8*unique(Ops.Vx)/tr.UNLOADED_RADIUS;
            omega_lo=0;







            omega_space_lo=linspace(omega_lo,omega_ilo,30);
            omega_space_mid=linspace(omega_ilo,omega_ihi,500+2);
            omega_space_hi=linspace(omega_ihi,omega_hi,30);
            Ops.Omega=[omega_space_lo,omega_space_mid(2:500+1),omega_space_hi]';

            Ops.Vy=zeros(Ops.dim,1);

            Ops.rho_z=deflectionEstimation(InflPress,Ops.Omega,gamma*ones(Ops.dim,1),Fz_load,Ops.Fx_ext,Ops.Fy_ext,Ops.scaleFactors,...
            tr.NOMPRES,tr.UNLOADED_RADIUS,tr.Q_RE0,tr.Q_V1,tr.Q_V2,tr.Q_FCX,tr.Q_FCY,tr.LONGVL,tr.VERTICAL_STIFFNESS,...
            tr.FNOMIN,tr.Q_FZ1,tr.Q_FZ2,tr.Q_FZ3,tr.PFZ1,tr.ASPECT_RATIO,tr.WIDTH,tr.Q_CAM1,tr.Q_CAM2,tr.Q_CAM3,tr.RIM_RADIUS);

            Ops.Re=tr.UNLOADED_RADIUS-Ops.rho_z;

        case "lateral"








            alpha_sweep=20*pi/180;
            Vy_lo=-tan(alpha_sweep)*unique(Ops.Vx);
            Vy_ilo=-tan(5*pi/180)*unique(Ops.Vx);
            Vy_ihi=tan(5*pi/180)*unique(Ops.Vx);
            Vy_hi=tan(alpha_sweep)*unique(Ops.Vx);







            Vy_space_lo=linspace(Vy_lo,Vy_ilo,30);
            Vy_space_mid=linspace(Vy_ilo,Vy_ihi,500+2);
            Vy_space_hi=linspace(Vy_ihi,Vy_hi,30);
            Ops.Vy=[Vy_space_lo,Vy_space_mid(2:500+1),Vy_space_hi]';

            for wi=1:length(Ops.Vy)
                itRe=ones(1000,1);
                itRho_z=ones(1000,1);
                itOmega=ones(1000,1);
                tol=ones(1000,1);

                itRe(1)=0.98*tr.UNLOADED_RADIUS;
                iter=2;
                while tol(iter-1)>0.001&&itRe(iter-1)<tr.UNLOADED_RADIUS&&iter<1000
                    itOmega(iter)=Ops.Vx(wi)/itRe(iter);
                    itRho_z(iter)=deflectionEstimation(InflPress,itOmega(iter),gamma*ones(Ops.dim,1),Fz_load,Ops.Fx_ext,Ops.Fy_ext,Ops.scaleFactors,...
                    tr.NOMPRES,tr.UNLOADED_RADIUS,tr.Q_RE0,tr.Q_V1,tr.Q_V2,tr.Q_FCX,tr.Q_FCY,tr.LONGVL,tr.VERTICAL_STIFFNESS,...
                    tr.FNOMIN,tr.Q_FZ1,tr.Q_FZ2,tr.Q_FZ3,tr.PFZ1,tr.ASPECT_RATIO,tr.WIDTH,tr.Q_CAM1,tr.Q_CAM2,tr.Q_CAM3,tr.RIM_RADIUS);
                    itRe(iter)=tr.UNLOADED_RADIUS-itRho_z(iter);
                    tol(iter)=abs(itRe(iter)-itRe(iter-1));iter=iter+1;
                end
                Ops.Re(wi,1)=itRe(iter-1);
                Ops.rho_z(wi,1)=itRho_z(iter-1);
            end

            Ops.Omega=sqrt(Ops.Vy.^2+Ops.Vx.^2)./Ops.Re;
        end


        [Fx,Fy,Fz,Mx,My,Mz,~,kappa,alpha,~,~,~,~]=vdyncsmtire(Ops.Omega,...
        Ops.Vx,...
        Ops.Vy,...
        Ops.psidot,...
        gamma*ones(Ops.dim,1),...
        InflPress,...
        Ops.scaleFactors,...
        Ops.rho_z,...
        plystr,...
        turnslip,...
        tr.PRESMAX,...
        tr.PRESMIN,...
        tr.FZMAX,...
        tr.FZMIN,...
        tr.VXLOW,...
        tr.KPUMAX,...
        tr.KPUMIN,...
        tr.ALPMAX,...
        tr.ALPMIN,...
        tr.CAMMIN,...
        tr.CAMMAX,...
        tr.LONGVL,...
        tr.UNLOADED_RADIUS,...
        tr.RIM_RADIUS,...
        tr.NOMPRES,...
        tr.FNOMIN,...
        tr.VERTICAL_STIFFNESS,...
        tr.DREFF,...
        tr.BREFF,...
        tr.FREFF,...
        tr.Q_RE0,...
        tr.Q_V1,...
        tr.Q_V2,...
        tr.Q_FZ1,...
        tr.Q_FZ2,...
        tr.Q_FCX,...
        tr.Q_FCY,...
        tr.PFZ1,...
        tr.Q_FCY2,...
        tr.BOTTOM_OFFST,...
        tr.BOTTOM_STIFF,...
        tr.PCX1,...
        tr.PDX1,...
        tr.PDX2,...
        tr.PDX3,...
        tr.PEX1,...
        tr.PEX2,...
        tr.PEX3,...
        tr.PEX4,...
        tr.PKX1,...
        tr.PKX2,...
        tr.PKX3,...
        tr.PHX1,...
        tr.PHX2,...
        tr.PVX1,...
        tr.PVX2,...
        tr.PPX1,...
        tr.PPX2,...
        tr.PPX3,...
        tr.PPX4,...
        tr.RBX1,...
        tr.RBX2,...
        tr.RBX3,...
        tr.RCX1,...
        tr.REX1,...
        tr.REX2,...
        tr.RHX1,...
        tr.QSX1,...
        tr.QSX2,...
        tr.QSX3,...
        tr.QSX4,...
        tr.QSX5,...
        tr.QSX6,...
        tr.QSX7,...
        tr.QSX8,...
        tr.QSX9,...
        tr.QSX10,...
        tr.QSX11,...
        tr.PPMX1,...
        tr.PCY1,...
        tr.PDY1,...
        tr.PDY2,...
        tr.PDY3,...
        tr.PEY1,...
        tr.PEY2,...
        tr.PEY3,...
        tr.PEY4,...
        tr.PEY5,...
        tr.PKY1,...
        tr.PKY2,...
        tr.PKY3,...
        tr.PKY4,...
        tr.PKY5,...
        tr.PKY6,...
        tr.PKY7,...
        tr.PHY1,...
        tr.PHY2,...
        tr.PVY1,...
        tr.PVY2,...
        tr.PVY3,...
        tr.PVY4,...
        tr.PPY1,...
        tr.PPY2,...
        tr.PPY3,...
        tr.PPY4,...
        tr.PPY5,...
        tr.RBY1,...
        tr.RBY2,...
        tr.RBY3,...
        tr.RBY4,...
        tr.RCY1,...
        tr.REY1,...
        tr.REY2,...
        tr.RHY1,...
        tr.RHY2,...
        tr.RVY1,...
        tr.RVY2,...
        tr.RVY3,...
        tr.RVY4,...
        tr.RVY5,...
        tr.RVY6,...
        tr.QSY1,...
        tr.QSY2,...
        tr.QSY3,...
        tr.QSY4,...
        tr.QSY5,...
        tr.QSY6,...
        tr.QSY7,...
        tr.QSY8,...
        tr.QBZ1,...
        tr.QBZ2,...
        tr.QBZ3,...
        tr.QBZ4,...
        tr.QBZ5,...
        tr.QBZ6,...
        tr.QBZ9,...
        tr.QBZ10,...
        tr.QCZ1,...
        tr.QDZ1,...
        tr.QDZ2,...
        tr.QDZ3,...
        tr.QDZ4,...
        tr.QDZ6,...
        tr.QDZ7,...
        tr.QDZ8,...
        tr.QDZ9,...
        tr.QDZ10,...
        tr.QDZ11,...
        tr.QEZ1,...
        tr.QEZ2,...
        tr.QEZ3,...
        tr.QEZ4,...
        tr.QEZ5,...
        tr.QHZ1,...
        tr.QHZ2,...
        tr.QHZ3,...
        tr.QHZ4,...
        tr.PPZ1,...
        tr.PPZ2,...
        tr.SSZ1,...
        tr.SSZ2,...
        tr.SSZ3,...
        tr.SSZ4,...
        tr.PDXP1,...
        tr.PDXP2,...
        tr.PDXP3,...
        tr.PKYP1,...
        tr.PDYP1,...
        tr.PDYP2,...
        tr.PDYP3,...
        tr.PDYP4,...
        tr.PHYP1,...
        tr.PHYP2,...
        tr.PHYP3,...
        tr.PHYP4,...
        tr.PECP1,...
        tr.PECP2,...
        tr.QDTP1,...
        tr.QCRP1,...
        tr.QCRP2,...
        tr.QBRP1,...
        tr.QDRP1,...
        tr.QDRP2,...
        tr.WIDTH,...
        tr.Q_RA1,...
        tr.Q_RA2,...
        tr.Q_RB1,...
        tr.Q_RB2,...
        tr.QSX12,...
        tr.QSX13,...
        tr.QSX14,...
        tr.Q_FZ3,...
        tr.LONGITUDINAL_STIFFNESS,...
        tr.LATERAL_STIFFNESS,...
        tr.PCFX1,...
        tr.PCFX2,...
        tr.PCFX3,...
        tr.PCFY1,...
        tr.PCFY2,...
        tr.PCFY3,...
        Ops.Fx_ext,...
        Ops.Fy_ext,...
        Ops.vdynMF);
    end


    function rho_z=deflectionEstimation(press,omega,gamma,Fz_ext,Fx_ext,Fy_ext,ScaleFctrs,...
        NOMPRES,UNLOADED_RADIUS,Q_RE0,Q_V1,Q_V2,Q_FCX,Q_FCY,LONGVL,VERTICAL_STIFFNESS,FNOMIN,Q_FZ1,Q_FZ2,Q_FZ3,PFZ1,ASPECT_RATIO,WIDTH,Q_CAM1,Q_CAM2,Q_CAM3,RIM_RADIUS)


        dpi=(press-NOMPRES)./NOMPRES;
        rho_z=zeros(size(omega));
        Rlstart=UNLOADED_RADIUS;
        Rlend=RIM_RADIUS;


        for i=1:length(omega)
            error=0;
            Rho_z_record=zeros(1000,1);
            Fz_record=zeros(1000,1);
            flag=0;
            ii=1;
            j=1;
            xq=Fz_ext;
            for r=Rlstart:-0.001:Rlend
                error_old=error;
                Romega=UNLOADED_RADIUS.*(Q_RE0+Q_V1.*((omega(i).*UNLOADED_RADIUS)./LONGVL).^2);
                [Fz_rho,Rho_z]=VerticalForceAndDeflection(r,Romega,gamma(i),omega(i),dpi,Fx_ext(i),Fy_ext(i),ScaleFctrs(:,i),...
                UNLOADED_RADIUS,Q_V2,Q_FCX,Q_FCY,LONGVL,VERTICAL_STIFFNESS,FNOMIN,Q_FZ1,Q_FZ2,Q_FZ3,PFZ1,ASPECT_RATIO,WIDTH,Q_CAM1,Q_CAM2,Q_CAM3);
                error=Fz_ext-Fz_rho;

                Rho_z_record(ii)=Rho_z;
                Fz_record(ii)=Fz_rho;
                ii=ii+1;

                if(r~=Rlstart)&&(error*error_old<0)
                    flag=1;
                end

                if flag==1
                    j=j+1;
                end

                if j==3
                    if ii>=3
                        v=Rho_z_record((ii-3):(ii-1));
                        x=Fz_record((ii-3):(ii-1));
                        rho_z(i)=interp1(x,v,xq,'spline');
                    else
                        rho_z(i)=Rho_z_record(ii-1);
                    end
                    break;
                end
            end
        end
    end

    function[Fz,rhoz]=VerticalForceAndDeflection(Rl,Romega,gamma,omega,dpi,Fx_ext,Fy_ext,scaleFactor,...
        UNLOADED_RADIUS,Q_V2,Q_FCX,Q_FCY,LONGVL,VERTICAL_STIFFNESS,FNOMIN,Q_FZ1,Q_FZ2,Q_FZ3,PFZ1,ASPECT_RATIO,WIDTH,Q_CAM1,Q_CAM2,Q_CAM3)

        lam_Fzo=scaleFactor(1,:)';


        if any(isempty(Q_FZ1))||any(Q_FZ1==0)
            Q_FZ1=sqrt((VERTICAL_STIFFNESS.*UNLOADED_RADIUS./FNOMIN).^2-4.*Q_FZ2);
        end
        Fzo_prime=lam_Fzo.*FNOMIN;





        rho_zfr=max(Romega-Rl,0);


        rtw=(1.075-0.5*ASPECT_RATIO)*WIDTH;


        rho_zg=((Q_CAM1.*Rl+Q_CAM2.*Rl.^2).*gamma).^2.*(rtw/8).*abs(tan(gamma))./((Q_CAM1.*Romega+Q_CAM2.*Romega.^2).*gamma).^2-(Q_CAM3.*rho_zfr.*abs(gamma));


        rho_zg(isnan(rho_zg))=0;


        rhoz=max(rho_zfr+rho_zg,0);


        Fz=(1+Q_V2.*abs(omega).*UNLOADED_RADIUS./LONGVL-(Q_FCX.*Fx_ext./FNOMIN).^2.-(Q_FCY.*Fy_ext./FNOMIN).^2).*...
        ((Q_FZ1+Q_FZ3.*gamma.^2).*rhoz./UNLOADED_RADIUS+Q_FZ2.*(rhoz./UNLOADED_RADIUS).^2).*(1+PFZ1.*dpi).*Fzo_prime;
    end
end

