/* Page.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/page.ui")]
public abstract class Gaussian.Page : Gtk.Box {
    [GtkChild]
    private unowned ResultsList results_list;

    public DistributionType distribution_type { get; construct; }

    // Abstract Methods
    public abstract GenericArray<Result> get_results ();

    construct {
    }
}
