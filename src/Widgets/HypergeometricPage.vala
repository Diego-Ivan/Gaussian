/* HypergeometricPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/hypergeometric-page.ui")]
public class Gaussian.HypergeometricPage : Gaussian.Page {
    [GtkChild]
    private unowned Adw.SpinRow n_row;
    [GtkChild]
    private unowned Adw.SpinRow m_row;
    [GtkChild]
    private unowned Adw.SpinRow population_row;

    private int n {
        get {
            return (int) n_row.value;
        }
    }

    private int m {
        get {
            return (int) m_row.value;
        }
    }

    private int size {
        get {
            return (int) population_row.value;
        }
    }

    public override GenericArray<Result> get_results () {
        var result_array = new GenericArray<Result> ();

        switch (data_list.selected_mode) {
            case UNDER_OR_EQUAL:
                result_array.add (under_or_equal_to ());
                break;
            case BETWEEN:
                result_array.add (between ());
                break;
            case EQUAL_TO:
                result_array.add (equal_to ());
                break;
            case OVER_OR_EQUAL:
                result_array.add (over_or_equal ());
                break;
            default:
                critical ("Unknown mode");
                break;
        }

        return result_array;
    }

    private Result[] descriptive_statistics () {
        Result[] array = {};

        array += new Result ("Mean", n * m/size);

        return array;
    }

    private Result equal_to () {
        return new Result ("P(X=x)", hypergeometric_distribution (data_list.x, n, m, size));
    }

    private Result under_or_equal_to () {
        return new Result ("P(X≤x)",
                           cumulative_hypergeometric_distribution (n, m, size, 0, data_list.x));
    }

    private Result between () {
        int lower = data_list.inferior_boundary;
        int upper = data_list.superior_boundary;

        return new Result ("P(I≤x≤X)",
                           cumulative_hypergeometric_distribution (n, m, size, lower, upper));
    }

    private Result over_or_equal () {
        double result = 1 - cumulative_hypergeometric_distribution (n, m, size, 0, data_list.x-1);

        return new Result ("P(X≥x)", result);
    }
}
