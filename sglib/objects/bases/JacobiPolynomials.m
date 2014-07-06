classdef JacobiPolynomials < PolynomialSystem
    % JACOBIPOLYNOMIALS Construct a JacobiPolynomials.
    % SYS=JACOBIPOLYNOMIALS(ALPHA,BETA) constructs polynomial system returned in
    % SYS, representing an orthogonal Jacobi polynomial.
    % Example (<a href="matlab:run_example JacobiPolynomials">run</a>)
    % sys=JacobiPolynomials(1,2);
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
        % The parameter ALPHA of Jacobi(ALPHA,beta) polynomial.
        alpha
        
        % The parameter ALPHA of Jacobi(ALPHA,beta) polynomial.
        beta
    end
    
    methods
        function sys=JacobiPolynomials(alpha,beta)
            % JACOBIPOLYNOMIALS Construct a JacobiPolynomials.
            % SYS=JACOBIPOLYNOMIALS(ALPHA,BETA) constructs polynomial system
            % returned in SYS, representing an orthogonal Jacobi polynomial
            % with parameters ALPHA and BETA.
            sys.alpha=alpha;
            sys.beta=beta;
        end
        function r=recur_coeff(sys,p)
            % RECUR_COEFF Compute recurrence coefficient of orthogonal polynomials.
            % R = RECUR_COEFF(SYS,P) computes the recurrence coefficients for
            % the system of orthogonal polynomials SYS of order P. The
            % signs are compatible with the ones given in Abramowith & Stegun 22.7:
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
            n = (0:p-1)';
            
            an = (sys.alpha^2-sys.beta^2)*(2*n+sys.alpha+sys.beta+1)...
                .*(2*n+sys.alpha+sys.beta);
            
            bn = (2*n+sys.alpha+sys.beta+1).*(2*n+sys.alpha+sys.beta+2);
            
            cn = 2*(n+sys.alpha).*(n+sys.beta).*(2*n+sys.alpha+sys.beta+2);
            
            denom=2*(n+1).*(n+sys.alpha+sys.beta+1).*(2*n+sys.alpha+sys.beta);
            
            r= bsxfun(@rdivide,[an,bn,cn],denom);
        end
    end
end