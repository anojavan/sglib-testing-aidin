function [u, iter, res, state] = general_iterative_solver(state, p, varargin)
% GENERAL_ITERATIVE_SOLVER Solves a nonlinear system iteratively by using a given step function.
%   GENERAL_ITERATIVE_SOLVER solves a nonlinear system of equations
%   iteratively. The parameter STEP_FUNC specifies a function handle
%   that computes the a solver step and the residual for a given approximate
%   solution U. Internal state that is needed by RESIDUAL_FUNC can be
%   stored in STATE. STATE should also contain a start value U0, i.e. the
%   starting value for U will be STATE.U0 is not specified otherwise. P
%   specifies a parameter vector that is also passed to RESIDUAL_FUNC.
%  
%   Options:
%       u0: start vector [state.u0]
%       max_iter: maximum number of iterations [100]
%       abstol: absolute stopping tolerance for the residual norm [1e-5]
%       verbose: display convergence information [false]
%
% Example (<a href="matlab:run_example nonlinear_solve_picard">run</a>)
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



options = varargin2options(varargin);
[u0, options] = get_option(options, 'u0', []);
[max_iter, options] = get_option(options, 'max_iter', 100);
[abstol, options] = get_option(options, 'abstol', 1e-5);
[verbose, options] = get_option(options, 'verbose', false);
check_unsupported_options(options, mfilename);

step_func = state.model_info.step_func;
res_func = state.model_info.res_func;

if isempty(u0)
    u = funcall(state.model_info.sol_init_func, p);
else
    u = u0;
end
for iter = 1:max_iter
    [res, state] = funcall(res_func, state, u, p);
    res_norm = norm(res);
    if verbose
        fprintf( 'nonlin_solve: iter %d, norm=%g\n', iter, res_norm);
    end
    if res_norm<abstol
        break;
    elseif iter==max_iter
        error('solve:no_conv', ...
            'Could not reach convergence (abstol=%g) in %d iterations', ...
            abstol, max_iter);
    end
    
    [u, state] = funcall(step_func, state, u, p);
end