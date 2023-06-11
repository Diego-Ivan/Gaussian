/* NumberRow.vala
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

public class Gaussian.NumberRow : Adw.ActionRow {
    private Gtk.SpinButton spin_button;
    public double @value {
        get {
            return spin_button.value;
        }
        set {
            spin_button.value = value;
        }
    }

    public uint digits {
        get {
            return spin_button.digits;
        }
        set {
            spin_button.digits = value;
        }
    }

    public double lower {
        get {
            return spin_button.adjustment.lower;
        }
        set {
            spin_button.adjustment.lower = value;
        }
    }

    public double upper {
        get {
            return spin_button.adjustment.upper;
        }
        set {
            spin_button.adjustment.upper = value;
        }
    }

    public double step {
        get {
            return spin_button.adjustment.step_increment;
        }
        set {
            spin_button.adjustment.step_increment = value;
        }
    }

    construct {
        spin_button = new Gtk.SpinButton.with_range (0, 100, 1) {
            numeric = true,
            valign = CENTER,
            width_chars = 7
        };
        add_suffix (spin_button);
    }
}
