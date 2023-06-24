/* NavigationSwitcher.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/navigation-switcher.ui")]
public class Gaussian.NavigationSwitcher : Adw.Bin {
    [GtkChild]
    private unowned Gtk.ListBox distribution_listbox;

    public bool enable_navigation { get; set; default = false; }

    private unowned NavigationStack _navigation_stack;
    public unowned NavigationStack navigation_stack {
        get {
            return _navigation_stack;
        }
        set {
            _navigation_stack = value;

            for (int i = 0; i < navigation_stack.pages_model.get_n_items (); i++) {
                var page = (Page) navigation_stack.pages_model.get_item (i);
                distribution_listbox.append (new DistributionRow (page));
            }
        }
    }

    [GtkCallback]
    private void on_row_selected (Gtk.ListBoxRow? row) {
        if (row == null) {
            return;
        }
        var distribution_row = (DistributionRow) row;
        navigation_stack.change_visible_page (distribution_row.navigation_page, enable_navigation);
        enable_navigation = true;
        distribution_listbox.unselect_all ();
    }
}
