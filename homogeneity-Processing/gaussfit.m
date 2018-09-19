%Gradient Descent fitting of Gaussian Curve
function [mu sig fun err] = gaussfit(l, z, Itern)
a = 0.5;
[Y I] = max(z);
mua = I;
sig = max(l)/4;
X = [mua;sig];
err = (z - exp(-0.5*(l - X(1)).^2/X(2)^2))'*(z - exp(-0.5*(l - X(1)).^2/X(2)^2));
dJ = @(muhat,sighat) [-(2*(l' - muhat)/sighat^2)*((z - exp(-0.5*(l - muhat).^2/sighat^2)).*exp(-0.5*(l - muhat).^2/sighat^2)); -(2*(l' - muhat).^2/sighat^3)*((z - exp(-0.5*(l - muhat).^2/sighat^2)).*exp(-0.5*(l - muhat).^2/sighat^2))];
for i = 1:Itern
    X = X - a*dJ(X(1),X(2));
%     err = [err ; (z - exp(-0.5*(l - X(1)).^2/X(2)^2))'*(z - exp(-0.5*(l - X(1)).^2/X(2)^2))];
    if(X(1) < 0 || X(1) > (max(l) - X(2)))
        X(1) = I;
    end
    if(X(2)<1 || X(2)> max(l)/2)
        X(2) = max(l)/4;
    end
        
end
mu = X(1);
sig = X(2);
fun = exp(-0.5*(l - mu).^2/sig^2);
err = (z - exp(-0.5*(l - X(1)).^2/X(2)^2))'*(z - exp(-0.5*(l - X(1)).^2/X(2)^2));
