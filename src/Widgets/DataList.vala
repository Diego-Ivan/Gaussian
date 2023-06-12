/* DataList.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/data-list.ui")]
public class Gaussian.DataList : Gtk.Box {
    [GtkChild]
    private unowned Adw.ComboRow mode_selection;
    [GtkChild]
    private unowned NumberRow x_row;
    [GtkChild]
    private unowned NumberRow inferior_row;
    [GtkChild]
    private unowned NumberRow superior_row;
    [GtkChild]
    private unowned Adw.ExpanderRow boundaries_expander;

    public bool uses_boundaries { get; private set; }

    private VariableType _variable_type;
    public VariableType variable_type {
        get {
            return _variable_type;
        }
        set {
            _variable_type = value;
            mode_selection.model = new VariableTypeListModel (variable_type);
        }
    }

    public VariableTypeMode selected_mode {
        get {
            return (VariableTypeMode) mode_selection.selected_item;
        }
    }

    public int x {
        get {
            return (int) x_row.value;
        }
    }

    public int inferior_boundary {
        get {
            return (int) inferior_row.value;
        }
    }

    public int superior_boundary {
        get {
            return (int) superior_row.value;
        }
    }

    [GtkCallback]
    private void on_mode_selection_changed () {
        uses_boundaries = selected_mode.require_boundaries;
        boundaries_expander.expanded = uses_boundaries;
    }
}
