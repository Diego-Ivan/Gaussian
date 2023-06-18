/* GeometricPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/geometric-page.ui")]
public class Gaussian.GeometricPage : Gaussian.Page {
    [GtkChild]
    private unowned Adw.SpinRow p_row;

    private double p {
        get {
            return p_row.value;
        }
    }

    public override GenericArray<Result> get_results () {
        unowned var discrete_mode = (DiscreteTypeMode) data_list.selected_mode;
        var result_array = new GenericArray<Result> ();

        switch (discrete_mode.mode) {
            case UNDER_OR_EQUAL:
                result_array.add (under_or_equal ());
                break;
            case BETWEEN:
                result_array.add (between ());
                break;
            case EQUAL_TO:
                result_array.add (equal_to ());
                break;
            case OVER_OR_EQUAL:
                result_array.add (over_or_equal_to ());
                break;
            default:
                critical ("Unknown mode");
                break;
        }

        foreach (Result measure in descriptive_statistics ()) {
            result_array.add (measure);
        }

        return result_array;
    }

    private Result[] descriptive_statistics () {
        Result[] measures = {};

        measures += new Result ("Mean", 1/p);
        measures += new Result ("Variance", (1-p)/p*p);

        return measures;
    }

    private Result under_or_equal () {
        return new Result ("P(X≤x)", cumulative_geometric_distribution (data_list.x, p));
    }

    private Result between () {
        int lower = data_list.inferior_boundary;
        int upper = data_list.superior_boundary;

        double result = cumulative_geometric_distribution (upper, p) - cumulative_geometric_distribution (lower - 1, p);
        return new Result ("P(I≤x≤X)", result);
    }

    private Result equal_to () {
        return new Result ("P(x=X)", geometric_distribution (p, data_list.x));
    }

    private Result over_or_equal_to () {
        double result = geometric_distribution_over (data_list.x - 1, p);
        return new Result ("P(X≥x)", result);
    }
}
