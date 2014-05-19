classdef HermitePolynomials < PolynomialSystem
    % HERMITEPOLYNOMIALS Construct a HermitePolynomials.
    % SYS=HERMITEPOLYNOMIALS(DEG) constructs polynomial system returned in
    % SYS, representing an orthogonal Hermite polynomial of order DEG.
    % Example (<a href="matlab:run_example HermitePolynomials">run</a>)
    % sys=HermitePolynomials(3);
    %
    % See also LEGENDREPOLYNOMIALS POLYNOMIALSYSTEM 
    
    %   Aidin Nojavan
    %   Copyright 2014, Inst. of Scientific Computing, TU Braunschweig
    %
    %   This program is free software: you can redistribute it and/or modify it
    %   under the terms of the GNU General Public License as published by the
    %   Free Software Foundation, either version 3 of the License, or (at your
    %   option) any later version.
    %   See the GNU General Public License for more details. You should have
    %   received a copy of the GNU General Public License along with this
    %   program.  If not, see <http://www.gnu.org/licenses/>.
    
    properties
        % The parameter DEG of the HermitePolynomials(DEG) system. DEG is
        % the order of the orthogonal Hermite polynomial system.
        deg
    end
    
    methods
        function sys=HermitePolynomials(deg)
            % HERMITEPOLYNOMIALS Construct a HermitePolynomials.
            % SYS=HERMITEPOLYNOMIALS(DEG) constructs polynomial system
            % returned in SYS, representing an orthogonal Hermite
            % polynomial of order DEG.
            sys.deg=deg;
        end
        function r=recur_coeff(sys)
            % RECUR_COEFF Compute recurrence coefficient of orthogonal polynomials.
            % R = RECUR_COEFF(SYS) computes the recurrence coefficients for
            % the system of orthogonal polynomials SYS. The signs are compatible with
            % the ones given in Abramowith & Stegun 22.7:
            %
            %       p_n+1  = (a_n + x b_n) p_n - c_n p_n-1
            %
            % Since matlab indices start at one, we have here the mapping
            %
            %       r(n,:) = (a_n-1, b_n-1, c_n-1)
            %
            % Furthermore the coefficients start here for p_1, so that only p_-1=0
            % and p_0=1 need to be fixed (otherwise p_1, would need to be another
            % parameter, since it's not always equal to x).
            n = (0:sys.deg-1)';
            one = ones(size(n));
            zero = zeros(size(n));
            r = [zero, one, n];
        end
    end
end
