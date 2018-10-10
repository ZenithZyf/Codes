% function[R1,R2]=diffuse(mua,mus)
% R1= (3.*.1792.*(mus/(mua+mus)))./((((sqrt(mua./(1./(3*(mua+mus)))))./(mua+mus))+1).*(((sqrt(mua./(1./(3*(mua+mus)))))./(mua+mus))+3.*.1792));
% R2 = (3.*0.1792.*(mus/(mua+mus)))./((((sqrt((sqrt(mua./(1./(3*(mua+mus))))).^2+(2.*pi.*0.1).^2))./(mua+mus))+1).*(((sqrt((sqrt(mua./(1./(3*(mua+mus))))).^2+(2.*pi.*0.1).^2))./(mua+mus))+3.*0.1792));
% end


function[Rd_DC,Rd_AC] = diffuse_equa(mua,musp)
	%%% This function is for calculate the theoretical diffuse reflectance of a standard phantom.
	% These diffuse reflectance will further be used in the calibration during image reconstruction.
	% For our phantom, mua = 0.003; musp = 0.8; both are mm^-1.

	% Temporarily, we assume that our source spatial frequency is 0.1 mm^-1 in x direction and 0 in y.
	% In the future, may be able to have an algorithm to extract the exact value from acquired images.
	fx_dc = 0;
	fx_ac = 0.1; % mm^-1.
	% Our phantom is silicone based, so choose refractive index approximately 1.33.
	n 	  = 1.33;

	% Effective reflection coefficient.
	R_eff = 0.0636*n+0.668+(0.71/n)-(1.44/(n^2));
	% The proportionality constant for the diffusion equation.
	A 	  = (1-R_eff)/(2*(1+R_eff));

	% The transport coefficient.
	mutr  = mua+musp;
	% The effective attenuation coefficient.
	mueff = sqrt(3.*mua.*mutr);

	% The scalar attenuation coefficient.
	mueffp_dc = mueff;
	mueffp_ac = sqrt(mueff.^2+(2.*pi.*fx_ac).^2);
	% The reduced albedo.
	ap    = musp./mutr;

	% The dc and ac diffuse reflectance. 
	Rd_DC = 3.*A.*ap./((mueffp_dc./mutr+1).*(mueffp_dc./mutr+3.*A));
	Rd_AC = 3.*A.*ap./((mueffp_ac./mutr+1).*(mueffp_ac./mutr+3.*A));
end




