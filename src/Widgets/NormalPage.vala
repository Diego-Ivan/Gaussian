/* NormalPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/normal-page.ui")]
public class Gaussian.NormalPage : Gaussian.Page {
    [GtkChild]
    private unowned Adw.SpinRow deviation_row;
    [GtkChild]
    private unowned Adw.SpinRow mean_row;

    private double mean {
        get {
            return mean_row.value;
        }
    }

    private double deviation {
        get {
            return deviation_row.value;
        }
    }

    public override GenericArray<Result> get_results () {
        var result_array = new GenericArray<Result> ();

        switch (data_list.selected_mode) {
            case UNDER_OR_EQUAL:
                result_array.add (under_or_equal ());
                break;
            case BETWEEN:
                result_array.add (between ());
                break;
            case OVER_OR_EQUAL:
                result_array.add (over_or_equal ());
                break;
            case EQUAL_TO:
            default:
                critical ("Mode not supported for this variable type");
                break;
        }

        foreach (Result result in descriptive_statistics ()) {
            result_array.add (result);
        }

        return result_array;
    }

    private Result[] descriptive_statistics () {
        Result[] array = {};

        array += new Result ("MAD", deviation * Math.SQRT2 * 1/Math.erf (0.5));

        return array;
    }

    private Result under_or_equal () {
        return new Result ("P(X≤x)", normal_distribution (data_list.x, deviation, mean));
    }

    private Result between () {
        int lower = data_list.inferior_boundary;
        int upper = data_list.superior_boundary;

        double result = normal_distribution (upper, deviation, mean) -
                        normal_distribution (lower, deviation, mean);

        return new Result ("P(I≤x≤X)", result);
    }

    private Result over_or_equal () {
        return new Result ("P(X≥x)", 1 - normal_distribution (data_list.x, deviation, mean));
    }
}
