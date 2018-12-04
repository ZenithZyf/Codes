function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated at the corresponding x value in the input

col = 1;

for index = 1:size(x,1)
	for i = 0:Q
		if i == 0
			z(i+1,col) = 1;
		elseif i == 1
			z(i+1,col) = x(index);
		else
			z(i+1,col) = ((2*i-1)/i)*x(index)*z(i,col) - ((i-1)/i)*z(i-1,col);
		end
	end
	col = col+1;
end

end