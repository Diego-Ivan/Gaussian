/* window.vala
 *
 * Copyright 2023 Diego Iván
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

namespace Gaussian {
    [GtkTemplate (ui = "/io/github/diegoivan/gaussian/window.ui")]
    public class Window : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Adw.NavigationView navigation_view;
        [GtkChild]
        private unowned Adw.WindowTitle distribution_title;

        public Window (Gtk.Application app) {
            Object (application: app);
        }

        static construct {
            typeof(BinomialPage).ensure ();
            typeof(PoissonPage).ensure ();
            typeof(GeometricPage).ensure ();
            typeof(HypergeometricPage).ensure ();
            typeof(NormalPage).ensure ();
            typeof(ChiSquaredPage).ensure ();
            typeof(StudentPage).ensure ();
            typeof(FDistributionPage).ensure ();
            typeof(DistributionRow).ensure ();
        }

        [GtkCallback]
        private void on_visible_child_changed (Object emitter, ParamSpec pspec) {
            var stack = (Gtk.Stack) emitter;
            Gtk.StackPage stack_page = stack.get_page (stack.visible_child);
            distribution_title.title = stack_page.title;

            navigation_view.push_by_tag ("distribution_view");
        }
    }
}
