/* PoissonPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/binomial-page.ui")]
public class Gaussian.PoissonPage : Gaussian.Page {
    [GtkChild]
    private unowned NumberRow mean_row;

    public override GenericArray<Result> get_results () {
        unowned var discrete_mode = (DiscreteTypeMode) data_list.selected_mode;
        var result_array = new GenericArray<Result> ();

        switch (discrete_mode.mode) {
            case UNDER_OR_EQUAL:
                // result_array.add (under_or_equal_result ());
                break;
            case BETWEEN:
                // result_array.add (between_to_result ());
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
    }

    private Result equal_to_result () {
        int mean = (int) mean_row.value;

        return new Result ("P(X=x)", poisson_distribution (data_list.x, mean));
    }

    private Result under_or_equal () {
        int mean = (int) mean_row.value;

        return new Result ("P(X≤x)", cumulative_poisson_distribution (mean, 0, data_list.x));
    }
}
