function [a_alpha, V] = gpc_param_expand(a_dist, sys, varargin)
% GPC_PARAM_EXPAND Short description of gpc_param_expand.
%   GPC_PARAM_EXPAND Long description of gpc_param_expand.
%
% Options
%
% References
%
% Notes
%
% Example (<a href="matlab:run_example gpc_param_expand">run</a>)
%
% See also

%   Elmar Zander
%   Copyright 2014, Inst. of Scientific Computing, TU Braunschweig
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

options=varargin2options(varargin);
[p,options]=get_option(options,'p', default);
[p_int,options]=get_option(options,'p_int', default);
[varerr,options]=get_option(options,'varerr', 0.01);
check_unsupported_options(options,mfilename);

check_type(sys, 'char', false, 'sys', mfilename);
check_range(length(sys), 1, 1, 'length(sys)', mfilename); 

if isequal(p,default)
    [a_mean, a_var] = gendist_moments(a_dist);
    for p=0:50
        V = gpcbasis_create(sys, 'p', p);
        p_int = max(10,2*p);
        a_alpha = do_param_expand(a_dist, V, p_int);
        [ag_mean, ag_var] = gpc_moments(a_alpha, V);
        if abs(a_var-ag_var)<varerr*a_var
            break;
        end
    end
else
    if isequal(p_int,default)
        p_int = max(10, 2*p);
    end
    V = gpcbasis_create(sys, 'p', p);
    a_alpha = do_param_expand(a_dist, V, p_int);
end
        

function d=default
d=@default;


function a_alpha = do_param_expand(a_dist, V, p_int)
[x,w]=gpc_integrate([], V, p_int);
psi_k_alpha = gpcbasis_evaluate(V, x, 'dual', true);
fun_k = gendist_invcdf(gpcgerm_cdf(V, x), a_dist{:});
a_alpha = fun_k*diag(w)*psi_k_alpha;