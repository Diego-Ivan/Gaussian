/* DistributionRow.vala
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

[GtkTemplate (ui = "/io/github/diegoivan/gaussian/gtk/distribution-row.ui")]
public class Gaussian.DistributionRow : Gtk.ListBoxRow {
    [GtkChild]
    private unowned Gtk.Image distribution_symbolic;
    [GtkChild]
    private unowned Gtk.Label distribution_label;
    [GtkChild]
    private unowned Gtk.Label description_label;

    private unowned Page _navigation_page;
    public unowned Page navigation_page {
        get {
            return _navigation_page;
        }
        set {
            _navigation_page = value;

            navigation_page.bind_property ("title", distribution_label, "label", SYNC_CREATE);
        }
    }

    public DistributionRow (Page navigation_page) {
        Object (navigation_page: navigation_page);
    }
}
