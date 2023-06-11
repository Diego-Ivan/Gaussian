/* enums.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public enum Gaussian.DistributionType {
    CONTINUOUS,
    DISCRETE;
}

public enum Gaussian.DiscreteMode {
    UNDER_OR_EQUAL,
    BETWEEN,
    OVER_OR_EQUAL,
    EQUAL_TO;
}

public enum Gaussian.ContinuousMode {
    UNDER,
    BETWEEN,
    OVER;
}
