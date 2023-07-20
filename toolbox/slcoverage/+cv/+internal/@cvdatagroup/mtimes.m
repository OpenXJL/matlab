function res=mtimes(lhs,rhs)



    lhs.load();
    rhs.load();

    if isa(rhs,lhs.getCvDataClassName())
        trhs=feval(lhs.getCvDataGroupClassName());
        init(trhs);
        trhs.add(rhs);
        rhs=trhs;
    end

    if~isa(lhs,lhs.getCvDataGroupClassName())||~isa(rhs,lhs.getCvDataGroupClassName())
        error(message('Slvnv:simcoverage:mtimes:InvalidArgument'));
    end
    lan=lhs.allNames(SlCov.CovMode.Mixed);
    ran=rhs.allNames(SlCov.CovMode.Mixed);
    ian=intersect(lan,ran);
    res=feval(lhs.getCvDataGroupClassName());
    init(res);
    for idx=1:numel(ian)
        res.add(lhs.get(ian{idx})*rhs.get(ian{idx}));
    end


