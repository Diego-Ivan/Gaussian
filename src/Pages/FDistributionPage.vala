/* FDistributionPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * This file is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 3 of the
 * License, or (at your option) any later version.
 *
 * This file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

using Gsl.CDF;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/pages/fdistribution-page.ui")]
public class Gaussian.FDistributionPage : Gaussian.Page {
    [GtkChild]
    private unowned Adw.SpinRow df1_row;
    [GtkChild]
    private unowned Adw.SpinRow df2_row;

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

        return result_array;
    }

    private Result under_or_equal () {
        return new Result ("P(X≤x)", fdist_P (data_list.x, df1_row.value, df2_row.value));
    }

    private Result between () {
        double lower = data_list.inferior_boundary;
        double upper = data_list.superior_boundary;

        double result = fdist_P (upper, df1_row.value, df2_row.value) -
                        fdist_P (lower, df1_row.value, df2_row.value);

        return new Result ("P(I≤x≤X)", result);
    }

    private Result over_or_equal () {
        return new Result ("P(X≥x)", fdist_Q (data_list.x, df1_row.value, df2_row.value));
    }
}
