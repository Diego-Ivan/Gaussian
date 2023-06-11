/* ResultsList.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/results-list.ui")]
public class Gaussian.ResultsList : Adw.PreferencesGroup {
    [GtkChild]
    private unowned Gtk.ListBox result_listbox;
    private ListStore results_model = new ListStore (typeof(Result));

    construct {
        result_listbox.bind_model (results_model, row_creator_func);
    }

    public void add_result (Result result) {
        results_model.append (result);
    }

    public void delete_all_results () {
        results_model.remove_all ();
    }

    [GtkCallback]
    private void on_copy_button_clicked () {
        unowned Gdk.Clipboard clipboard = get_clipboard ();

        // We will copy the results in CSV format
        var string_builder = new StringBuilder ();

        for (int i = 0; i < results_model.n_items; i++) {
            var result = (Result) results_model.get_object (i);
            string_builder.append_printf ("%s:%s\n", result.name, result.value.to_string ());
        }

        clipboard.set_text (string_builder.str);
    }

    private Gtk.Widget row_creator_func (Object object) {
        var result = (Result) object;

        var value_label = new Gtk.Label (result.value.to_string ()) {
            css_classes = { "dim-label" }
        };

        var child_row = new Adw.ActionRow () {
            title = result.name
        };
        child_row.add_suffix (value_label);

        return child_row;
    }
}
