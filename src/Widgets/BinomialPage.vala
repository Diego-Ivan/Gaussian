/* BinomialPage.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gaussian.MathUtils;
using Math;

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/binomial-page.ui")]
public class Gaussian.BinomialPage : Gtk.Box {
    [GtkChild]
    private unowned NumberRow x_row;
    [GtkChild]
    private unowned NumberRow n_row;
    [GtkChild]
    private unowned NumberRow p_row;
    [GtkChild]
    private unowned Gtk.Label result_label;

    [GtkCallback]
    private void on_execute_button_clicked () {
        int x = (int) x_row.value;
        int n = (int) n_row.value;
        double p = p_row.value;
        message (p.to_string ());
        long binomial_coefficient = factorial (n) / (factorial(n-x) * factorial(x));
        message (binomial_coefficient.to_string ());
        double result = binomial_coefficient * pow (p, x) * pow (1-p, n-x);

        result_label.label = result.to_string ();
    }
}
