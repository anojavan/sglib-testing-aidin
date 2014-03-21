
function unittest_UniformDistribution
% UNITTEST_UNIFORMDISTRIBUTION Test the UNIFORMDISTRIBUTION function.


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

munit_set_function( 'UniformDistribution' );

%%Initialization
U=UniformDistribution(2,4);
assert_equals( U.a, 2, 'Initialization a' );
assert_equals( U.b, 4, 'Initialization b' );

U=UniformDistribution(-1);
assert_equals( U.a, -1, 'Initialization default a' );
assert_equals( U.b, 1, 'Initialization default b' );

U=UniformDistribution();
assert_equals( U.a, 0, 'Initialization a' );
assert_equals( U.b, 1, 'Initialization b' );


%% uniform_cdf
U=UniformDistribution(2,4);
assert_equals(cdf(U,1.9), 0, 'cdf_smaller' );
assert_equals(cdf(U,2.5), 1/4, 'cdf_inside' );
assert_equals(cdf(U,5), 1, 'cdf_larger' );
assert_equals(cdf(U,(U.a+U.b)/2), 1/2, 'cdf_median' );


%% uniform_pdf
U=UniformDistribution(2,4);
assert_equals( pdf(U,-inf), 0, 'pdf_minf' );
assert_equals( pdf(U,3.5), 1/2, 'pdf_inside' );
assert_equals( pdf(U,inf), 0, 'pdf_inf' );

% pdf matches cdf
x1=linspace( -0.1, 5 );
x2 = (x1(1:end-1)+x1(2:end))/2;
F=cdf( U,x1);
F2=pdf_integrate( pdf( U,x2 ), F, x1);
assert_equals( F, F2, 'pdf_cdf_match', struct('abstol',0.01) );

%% uniform_invcdf
y = linspace(0, 1);

U=UniformDistribution();
x = linspace(0, 1);
assert_equals( cdf(U,invcdf(U,y)), y, 'cdf_invcdf_1');
assert_equals( invcdf(U,cdf(U,x)), x, 'invcdf_cdf_1');
assert_equals( isnan(invcdf(U,[-0.1, 1.1])), [true, true], 'invcdf_nan1');

U=UniformDistribution(0.5);
x = linspace(0.5, 1);
assert_equals(cdf(U,invcdf(U,y)), y, 'cdf_invcdf_2');
assert_equals(invcdf(U,cdf(U,x)), x, 'invcdf_cdf_2');
assert_equals( isnan(invcdf(U,[-0.1, 1.1])), [true, true], 'invcdf_nan2');

U=UniformDistribution(-2,3);
x = linspace(-2, 3);
assert_equals(cdf(U,invcdf(U,y)), y, 'cdf_invcdf_3');
assert_equals( invcdf(U,cdf(U,x)), x, 'invcdf_cdf_3');
assert_equals( isnan(invcdf(U,[-0.1, 1.1])), [true, true], 'invcdf_nan3');


%% uniform_stdnor
N=50;
uni=linspace(0,1,N+2)';
uni=uni(2:end-1);
gam=sqrt(2)*erfinv(2*uni-1);

U=UniformDistribution(0.2,1.3);
x=stdnor(U,gam );
assert_equals(cdf(U,x), uni, 'uniform' )
U=UniformDistribution(0,1);
assert_equals(uniform_stdnor(gam), stdnor(U,gam), 'uniform_def12');
assert_equals(uniform_stdnor(gam, 0),stdnor(U,gam), 'uniform_def2');

% %% uniform_raw_moments
% munit_set_function( 'uniform_raw_moments' );
% 
% % some precomputed moments
% expected=[ 1.0, 0.5, 0.33333333333333331, 0.25, 0.20000000000000001, ...
%     0.16666666666666666, 0.14285714285714285, 0.125, 0.1111111111111111, ...
%     0.10000000000000001, 0.090909090909090912];
% assert_equals( expected, uniform_raw_moments( 0:10, 0, 1 ), 'a0b1' );
% 
%   
% expected=[ 1.0, 2.6000000000000001, 7.1633333333333331, ...
%     20.722000000000001, 62.349620000000009, 193.5102866666667];
% assert_equals( expected(1+[3,1,5])', uniform_raw_moments( [3;1;5], 1.5, 3.7 ), 'a15b37' );
% 
% expected=[ 1, 2, 4, 8, 16];
% assert_equals( expected, uniform_raw_moments( 0:4, 2, 2 ), 'a2b2' );
% 
% % limit case for a==b
% assert_equals( uniform_raw_moments(0:5, 3, 3), 3.^(0:5), 'limit_a_eq_b');
% 
% % test default arguments
% assert_equals( uniform_raw_moments(0:5), uniform_raw_moments(0:5, 0, 1), 'def_12');
% assert_equals( uniform_raw_moments(0:5, 0.3), uniform_raw_moments(0:5, 0.3, 1), 'def_2');
% 


function F2=pdf_integrate( f, F, x )
F2=cumsum([F(1), f])*(x(2)-x(1));