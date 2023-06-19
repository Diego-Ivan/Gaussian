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
    public ulong factorial (int number)
        requires (number >= 0)
    {
        ulong factorial = 1l;
        for (int i = number; i > 0; i--) {
            factorial *= i;
        }
        return factorial;
    }

    public ulong binomial_coefficient (int n, int k) {
        return factorial (n) / ((factorial (n-k) * factorial (k)));
    }

    public double binomial_distribution (int x, int n, double p)
        requires (p < 1)
        requires (p >= 0)
        requires (n >= 0)
        requires (x >= 0)
        requires (x <= n)
    {
        double q = 1 - p;
        double b_coefficient = factorial (n) / ((factorial (n-x) * factorial (x)));

        return b_coefficient * pow (p, x) * pow (q, n - x);
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
        ulong successes = binomial_coefficient (m, x);
        message ((size-m).to_string ());
        message ((n-x).to_string ());
        ulong failures = binomial_coefficient (size - m, n - x);

        return ((double) (successes * failures)) / (double) binomial_coefficient (size, n);
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
}
