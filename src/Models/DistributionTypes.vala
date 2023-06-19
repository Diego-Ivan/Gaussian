/* DistributionTypes.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Gaussian.VariableTypeListModel : Object, ListModel {
    private GenericArray<CumulativeModeModel> model_array = new GenericArray<CumulativeModeModel> ();
    private VariableType _variable_type;
    public VariableType variable_type {
        get {
            return _variable_type;
        }
        construct {
            _variable_type = value;
            add_items_per_variable_type ();
        }
    }

    public VariableTypeListModel (VariableType type) {
        Object (variable_type: type);
    }

    public Object? get_item (uint position)
        requires (position < model_array.length)
    {
        return model_array[position];
    }

    public Object? get_object (uint position) {
        return get_item (position);
    }

    public Type get_item_type () {
        return typeof (CumulativeModeModel);
    }

    public uint get_n_items () {
        return model_array.length;
    }

    private void add_items_per_variable_type () {
        if (variable_type == DISCRETE) {
            model_array.add (new CumulativeModeModel (EQUAL_TO));
        }

        model_array.add (new CumulativeModeModel (UNDER_OR_EQUAL));
        model_array.add (new CumulativeModeModel (BETWEEN));
        model_array.add (new CumulativeModeModel (OVER_OR_EQUAL));
    }
}

public class Gaussian.CumulativeModeModel : Object {
    public CumulativeMode mode { get; set; default = 0x0; }
    public string name {
        owned get {
            return mode.to_string ();
        }
    }
    public bool requires_boundaries {
        get {
            return mode == BETWEEN;
        }
    }

    public CumulativeModeModel (CumulativeMode mode) {
        Object (mode: mode);
    }
}
