/* Page.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/pages/page.ui")]
public abstract class Gaussian.Page : Adw.Bin, Gtk.Buildable {
    [GtkChild]
    private unowned ResultsList results_list;
    [GtkChild]
    protected unowned DataList data_list;
    [GtkChild]
    private unowned Gtk.Box content_box;

    private VariableType _variable_type;
    public VariableType variable_type {
        get {
            return _variable_type;
        }
        set {
            _variable_type = value;
            data_list.variable_type = value;
        }
    }

    public Support x_support {
        get {
            return data_list.x_support;
        }
        set {
            data_list.x_support = value;
        }
    }

    public string title { get; set; default = ""; }
    public string tag { get; set; default = ""; }
    public string description { get; set; default = ""; }
    public string icon_name { get; set; default = ""; }

    // Abstract Methods
    public abstract GenericArray<Result> get_results ();

    public void add_child (Gtk.Builder builder, Object object, string? type) {
        if (!(object is Gtk.Widget) || content_box == null) {
            base.add_child (builder, object, type);
            return;
        }

        content_box.insert_child_after ((Gtk.Widget) object, data_list);
    }

    [GtkCallback]
    private void on_execute_button_clicked () {
        results_list.delete_all_results ();
        foreach (Result result in get_results ()) {
            results_list.add_result (result);
        }

        results_list.visible = true;
        results_list.grab_focus ();
    }
}
