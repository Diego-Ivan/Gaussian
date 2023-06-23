/* MathUtils.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
namespace Gaussian.MathUtils {
    public const double INV_SQRT2 = 0.707106781187;
    public const double INV_PI = 0.564189583548;

    public double factorial (int number)
        requires (number >= 0)
    {
        double factorial = 1;
        for (int i = number; i > 0; i--) {
            factorial *= i;
        }
        return factorial;
    }

    /**
     * This function calculates the binomial coefficient of two numbers
     *
     * For this function, we will reduce the expression n!/x!, as x < n, we will divide x/n and
     * multiply that number by x-1/n-1 and so on, until n = 2, as it really doesn't make sense
     * to go down to n = 1. Now that we have that number, we will calculate (n-k)! and divide
     * the previous product by the (n-k)!, in which we will use the factorial function above :)
     */
    public double binomial_coefficient (int n, int k) {
        return (falling_factorial (n, k) / factorial (n-k));
    }

    public double binomial_distribution (int x, int n, double p)
        requires (p < 1)
        requires (p >= 0)
        requires (n >= 0)
        requires (x >= 0)
        requires (x <= n)
    {
        double q = 1 - p;
        return binomial_coefficient (n, x) * pow (p, x) * pow (q, n - x);
    }

    public double cumulative_binomial_distribution (int n, double p, int lower, int upper)
        requires (lower < upper)
        requires (lower >= 0)
        requires (upper <= n)
        requires (p >= 0)
        requires (p < 1)
        requires (n >= 0)
    {
        double sum = 0;
        for (int i = lower; i <= upper; i++) {
            sum += binomial_distribution (i, n, p);
        }
        return sum;
    }

    public double poisson_distribution (int x, int mean)
        requires (x >= 0)
        requires (mean > 0)
    {
        return (pow (mean, x) * pow (Math.E, -1 * mean) / factorial (x));
    }

    public double cumulative_poisson_distribution (int mean, int lower, int upper)
        requires (lower < upper)
        requires (lower >= 0)
    {
        double sum = 0;
        for (int i = lower; i <= upper; i++) {
            sum += poisson_distribution (i, mean);
        }
        return sum;
    }

    public double geometric_distribution (double p, int n)
        requires (p >= 0 && p <= 1)
        requires (n >= 0)
    {
        double q = 1 - p;
        return p * pow (q, n-1);
    }

    public double cumulative_geometric_distribution (int n, double p)
        requires (p >= 0 && p <= 1)
        requires (n >= 0)
    {
        return 1-(Math.pow (1-p, n));
    }

    public double geometric_distribution_over (int n, double p) {
        return pow (1-p, n);
    }

    public double hypergeometric_distribution (int x, int n, int m, int size)
        requires (x >= 0)
        requires (x <= size)
        requires (n >= 0)
        requires (m >= 0)
        requires (n <= size)
        requires (m <= size)
    {
        double successes = binomial_coefficient (m, x);
        double failures = binomial_coefficient (size - m, n - x);

        return  (successes * failures) / binomial_coefficient (size, n);
    }

    public double cumulative_hypergeometric_distribution (int n, int m, int size, int lower, int upper)
        requires (n >= 0)
        requires (m >= 0)
        requires (n <= size)
        requires (m <= size)
        requires (lower >= 0)
        requires (lower < upper)
    {
        double sum = 0;
        for (int i = lower; i <= upper; i++) {
            sum += hypergeometric_distribution (i, n, m, size);
        }
        return sum;
    }

    public double normal_distribution (int x, double dev, double mean)
    {
        double err = (x-mean) * INV_SQRT2 * 1/dev;

        return 0.5 * (1+erf (err));
    }

    public double chi_squared_distribution (int x, int df)
        requires (df > 0)
    {
        int res_gamma;
        double gamma = Calculus.gammad (x*0.5, df*0.5, out res_gamma);
        return gamma;
    }

    public double falling_factorial (int m, int n) {
        double product = 1;
        for (int i = n+1; i <= m; i++) {
            product*=i;
        }
        return product;
    }
}
