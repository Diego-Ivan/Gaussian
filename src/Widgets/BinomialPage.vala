/* BinomialPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;
using Math;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/binomial-page.ui")]
public class Gaussian.BinomialPage : Gaussian.Page {
    [GtkChild]
    private unowned NumberRow n_row;
    [GtkChild]
    private unowned NumberRow p_row;

    public override GenericArray<Result> get_results () {
        unowned var discrete_mode = (DiscreteTypeMode) data_list.selected_mode;
        var result_array = new GenericArray<Result> ();

        switch (discrete_mode.mode) {
            case UNDER_OR_EQUAL:
                result_array.add (under_or_equal_result ());
                break;
            case BETWEEN:
                result_array.add (between_to_result ());
                break;
            case EQUAL_TO:
                result_array.add (equal_to_result ());
                break;
            case OVER_OR_EQUAL:
                result_array.add (over_or_equal_result ());
                break;
            default:
                critical ("Unknown mode");
                break;
        }

        foreach (Result result in descriptive_statistics ()) {
            result_array.add (result);
        }

        return result_array;
    }

    private Result[] descriptive_statistics () {
        int n = (int) n_row.value;
        double p = p_row.value;
        double q = 1-p;

        Result[] array = {};
        array += new Result () {
            name = "Mean",
            value = n * p
        };

        array += new Result () {
            name = "Variance",
            value = n * p * q
        };

        array += new Result () {
            name = "Skewness",
            value = (q - p) / sqrt (n * p * q)
        };

        return array;
    }

    private Result equal_to_result () {
        int n = (int) n_row.value;
        double p = p_row.value;

        var result = new Result () {
            name = "P(X=x)",
            value = binomial_distribution (data_list.x, n, p)
        };

        return result;
    }

    private Result under_or_equal_result () {
        int n = (int) n_row.value;
        double p = p_row.value;

        var result = new Result () {
            name = "P(X≤x)",
            value = cumulative_binomial_distribution (n, p, 0, data_list.x)
        };

        return result;
    }

    private Result between_to_result () {
        int n = (int) n_row.value;
        double p = p_row.value;
        int lower = data_list.inferior_boundary;
        int upper = data_list.superior_boundary;

        var result = new Result () {
            name = "P(I≤x≤X)",
            value = cumulative_binomial_distribution (n, p, lower, upper)
        };
        return result;
    }

    private Result over_or_equal_result () {
        int n = (int) n_row.value;
        double p = p_row.value;

        var result = new Result () {
            name = "P(X≥x)",
            value = cumulative_binomial_distribution (n, p, data_list.x, n)
        };

        return result;
    }
}
