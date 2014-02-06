function state = model_init(num_params, num_vars, varargin)
% MODEL_INIT Short description of model_init.
%   MODEL_INIT Long description of model_init.
%
% Options
%
% Example (<a href="matlab:run_example model_init">run</a>)
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
[solve_func, options] = get_option(options, 'solve_func', funcreate(@display_missing_func_error, 'solve_func'));
[step_func, options] = get_option(options, 'step_func', funcreate(@display_missing_func_error, 'step_func'));
[res_func, options] = get_option(options, 'res_func', funcreate(@display_missing_func_error, 'res_func'));
[sol_init_func, options] = get_option(options, 'sol_init_func', funcreate(@display_missing_func_error, 'sol_init_func'));
check_unsupported_options(options, mfilename);

info = struct();
info.num_params = num_params;
info.num_vars = num_vars;
info.solve_func = solve_func;
info.step_func = step_func;
info.res_func = res_func;
info.sol_init_func = sol_init_func;

stats = struct();
stats.num_solve_calls = 0;
stats.num_step_calls = 0;
stats.time_solve_calls = 0;
stats.time_step_calls = 0;

state = struct();
state.model_info = info;
state.model_stats = stats;

function display_missing_func_error(which_func)
error('sglib:compute_somthing', 'Function %s was not specified, but was needed by the algorithm', which_func);
