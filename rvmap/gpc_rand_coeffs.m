function x_i_alpha = gpc_rand_coeffs(V_x, Nx)
% GPC_RAND_COEFFS Create some random coefficients for a GPC for testing purposes.
%   X_I_ALPHA = GPC_RAND_COEFFS(V_X, NX) creates GPC coefficients for
%   testing purposes. X_I_ALPHA will contain NX time "size of V_X"
%   coefficients. The coefficients will be computed randomly but with some
%   exponentially decaying factor.
%
% Example (<a href="matlab:run_example gpc_rand_coeffs">run</a>)
%
% See also

%   Elmar Zander
%   Copyright 2013, Inst. of Scientific Computing, TU Braunschweig
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

I_x=V_x{2};

Mx = gpcbasis_size(V_x, 1);
x_i_alpha = rand(Nx, Mx)+0.2;
x_i_alpha = binfun(@times, x_i_alpha, 10.^(-multiindex_order(I_x)'));
