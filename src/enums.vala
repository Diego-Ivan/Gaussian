/* enums.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public enum Gaussian.VariableType {
    CONTINUOUS,
    DISCRETE;
}

public enum Gaussian.CumulativeMode {
    UNDER_OR_EQUAL,
    BETWEEN,
    OVER_OR_EQUAL,
    EQUAL_TO;

    public string to_string () {
        switch (this) {
            case UNDER_OR_EQUAL:
                return "x≤";
            case BETWEEN:
                return "≤x≤";
            case EQUAL_TO:
                return "x=";
            case OVER_OR_EQUAL:
                return "x≥";
            default:
                assert_not_reached ();
        }
    }
}

public enum Gaussian.Support {
    ALL_REAL,
    NATURAL,
    REAL_POSITIVE;
}
