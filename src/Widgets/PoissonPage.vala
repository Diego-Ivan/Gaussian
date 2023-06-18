/* PoissonPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/poisson-page.ui")]
public class Gaussian.PoissonPage : Gaussian.Page {
    [GtkChild]
    private unowned Adw.SpinRow mean_row;

    public override GenericArray<Result> get_results () {
        var result_array = new GenericArray<Result> ();

        switch (data_list.selected_mode) {
            case UNDER_OR_EQUAL:
                result_array.add (under_or_equal ());
                break;
            case BETWEEN:
                result_array.add (between ());
                break;
            case EQUAL_TO:
                result_array.add (equal_to_result ());
                break;
            case OVER_OR_EQUAL:
                // result_array.add (over_or_equal_result ());
                break;
            default:
                critical ("Unknown mode");
                break;
        }

        return result_array;
    }

    private Result equal_to_result () {
        int mean = (int) mean_row.value;

        return new Result ("P(X=x)", poisson_distribution (data_list.x, mean));
    }

    private Result under_or_equal () {
        int mean = (int) mean_row.value;

        return new Result ("P(X≤x)", cumulative_poisson_distribution (mean, 0, data_list.x));
    }

    private Result between () {
        int mean = (int) mean_row.value;
        int lower = data_list.inferior_boundary;
        int upper = data_list.superior_boundary;

        return new Result ("P(I≤x≤X)", cumulative_poisson_distribution (mean, lower, upper));
    }
}
