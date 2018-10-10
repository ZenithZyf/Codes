function[MuaF,MuspF] = fsolveLUT(step)

    account = 1;
    % Practically, Rac is range from 0.05 to 0.65
    for Rac = step:step:1
        dccount = 1;
        % Practically, Rdc ranges from Rac to 1.86 for a certain Rac
        for Rdc = Rac+step:step:2
            ref(1,1) = Rdc; ref(2,1) = Rac;
            fun = @(mu) root2d(mu,ref);
            x0 = [0.0000000000001,0.0000001];
            x = fsolve(fun,x0);
            MuaF(dccount,account)  = x(1);
            MuspF(dccount,account) = x(2);
            dccount = dccount+1;
        end
        account = account+1;
    end
    save('fsolveTable.mat','MuaF','MuspF','step');

end