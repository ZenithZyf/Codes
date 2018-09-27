function[] = cal_Lookup_Table(mua_max,musp_max)
	%%% In this function, we take the possible max mua and musp and then generate the lookup table.
	%%% We prefer mua_max = 5 and musp_max = 7 in mm^-1.

	% coarsely meshgrid potential mua and musp
	[mua,    musp] = meshgrid(0:0.01:mua_max, 0.01:0.01:musp_max); %mm-1
	% calculate corresponding Rd_DC and Rd_AC using diffuse_equa
	[Rd_DC, Rd_AC] = arrayfun(@diffuse_equa, mua, musp); %fx = 0.1 mm-1

	% figure; mesh(Rd_DC); grid on;
	% figure; mesh(Rd_AC); grid on;

	% get the maximum and minimum for further interpolation
	DCMax = roundn(max(Rd_DC(:)),-4); 
	DCMin = roundn(min(Rd_DC(:)),-4);
	ACMax = roundn(max(Rd_AC(:)),-4);
	ACMin = roundn(min(Rd_AC(:)),-4);
	inter_step = 0.0001;
	% save them
	save('interPara.mat','DCMax','DCMin','ACMax','ACMin');
	% fine mesh based on max and min values.
	[Rd_DC_Interpolate, Rd_AC_Interpolate] = meshgrid(DCMin:inter_step:DCMax, ACMin:inter_step:ACMax);
	% fine interpolation to get a table mapping Rd_DC and Rd_AC to mua and musp
	MuaI  = griddata(Rd_DC(:), Rd_AC(:), mua(:),  Rd_DC_Interpolate, Rd_AC_Interpolate, 'cubic');
	MuspI = griddata(Rd_DC(:), Rd_AC(:), musp(:), Rd_DC_Interpolate, Rd_AC_Interpolate, 'cubic');

	figure;
	mesh(Rd_DC_Interpolate,Rd_AC_Interpolate,MuaI),  hold on
	% plot3(R1(:), R2(:), mua(:),'o');

	figure;
	mesh(Rd_DC_Interpolate,Rd_AC_Interpolate,MuspI), hold on
	% plot3(R1(:), R2(:), musp(:), 'o');

	% save them
	save MuaI.mat  MuaI;
	save MuspI.mat MuspI;

end

% r1 = .707;
% r2 = 0.346;
% 
% column =  fix((r1-0.001)/0.001 + 1);
% row = fix((r2-0.001)/0.001 + 1);
% Mua = MuaI(row, column)
% Musp = MuspI(row, column)
% 
% [testR1, testR2] = arrayfun(@diffuse, Mua, Musp)





