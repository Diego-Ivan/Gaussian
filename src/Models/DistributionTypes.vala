/* DistributionTypes.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Gaussian.ContinuousModel : Object {
    public Gaussian.ContinuousMode mode { get; set; default = 0x0; }

    public ContinuousModel (ContinuousMode mode) {
        Object (mode: mode);
    }

    public string to_string () {
        switch (mode) {
            case UNDER:
                return "x≤";
            case BETWEEN:
                return "≤x≤";
            case OVER:
                return "x≥";
            default:
                assert_not_reached ();
        }
    }
}

public class Gaussian.DiscreteModel : Object {
    public Gaussian.DiscreteMode mode { get; set; default = 0x0; }

    public DiscreteModel (DiscreteMode mode) {
        Object (mode: mode);
    }

    public string to_string () {
        switch (mode) {
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
