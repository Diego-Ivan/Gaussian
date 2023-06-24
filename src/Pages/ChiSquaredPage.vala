/* ChiSquaredPage.vala
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

using Gaussian.MathUtils;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/pages/chisquared-page.ui")]
public class Gaussian.ChiSquaredPage : Gaussian.Page {
    [GtkChild]
    private unowned Adw.SpinRow df_row;

    private int df {
        get {
            return (int) df_row.value;
        }
    }

    public override GenericArray<Result> get_results () {
        var result_array = new GenericArray<Result> ();

        switch (data_list.selected_mode) {
            case UNDER_OR_EQUAL:
                result_array.add (under_or_equal ());
                break;
            case BETWEEN:
                // result_array.add (between ());
                break;
            case OVER_OR_EQUAL:
                // result_array.add (over_or_equal ());
                break;
            case EQUAL_TO:
            default:
                critical ("Mode not supported for this variable type");
                break;
        }

        return result_array;
    }

    public Result under_or_equal () {
        return new Result ("P(X≤x)", chi_squared_distribution (data_list.x, df));
    }
}
