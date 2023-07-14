/* NavigationSwitcher.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/navigation-switcher.ui")]
public class Gaussian.NavigationSwitcher : Adw.Bin {
    [GtkChild]
    private unowned Gtk.ListBox discrete_listbox;
    [GtkChild]
    private unowned Gtk.ListBox continuous_listbox;

    private unowned NavigationStack _navigation_stack;
    public unowned NavigationStack navigation_stack {
        get {
            return _navigation_stack;
        }
        set {
            _navigation_stack = value;

            for (int i = 0; i < navigation_stack.pages_model.get_n_items (); i++) {
                var page = (Page) navigation_stack.pages_model.get_item (i);

                if (page.variable_type == CONTINUOUS) {
                    continuous_listbox.append (new DistributionRow (page));
                    continue;
                }
                discrete_listbox.append (new DistributionRow (page));
            }
        }
    }

    [GtkCallback]
    private void on_row_selected (Gtk.ListBoxRow row) {
        var distribution_row = (DistributionRow) row;
        navigation_stack.change_visible_page (distribution_row.navigation_page);

        discrete_listbox.unselect_all ();
        continuous_listbox.unselect_all ();

        distribution_row.grab_focus ();
    }
}
