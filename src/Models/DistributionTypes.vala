/* DistributionTypes.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Gaussian.VariableTypeListModel : Object, ListModel {
    private GenericArray<VariableTypeMode> model_array = new GenericArray<VariableTypeMode> ();
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
        return typeof (VariableTypeMode);
    }

    public uint get_n_items () {
        return model_array.length;
    }

    private void add_items_per_variable_type () {
        if (variable_type == CONTINUOUS) {
            model_array.add (new ContinuousTypeMode (UNDER));
            model_array.add (new ContinuousTypeMode (BETWEEN));
            model_array.add (new ContinuousTypeMode (OVER));
            return;
        }

        model_array.add (new DiscreteTypeMode (UNDER_OR_EQUAL));
        model_array.add (new DiscreteTypeMode (BETWEEN));
        model_array.add (new DiscreteTypeMode (OVER_OR_EQUAL));
        model_array.add (new DiscreteTypeMode (EQUAL_TO));
    }
}

public abstract class Gaussian.VariableTypeMode : Object {
    public abstract string name { owned get; }
    public abstract bool require_boundaries { get; }
}

public class Gaussian.ContinuousTypeMode : Gaussian.VariableTypeMode {
    public Gaussian.ContinuousMode mode { get; set; default = 0x0; }
    public override string name {
        owned get {
            return mode.to_string ();
        }
    }

    public override bool require_boundaries {
        get {
            return mode == BETWEEN;
        }
    }

    public ContinuousTypeMode (ContinuousMode mode) {
        Object (mode: mode);
    }
}

public class Gaussian.DiscreteTypeMode : VariableTypeMode {
    public Gaussian.DiscreteMode mode { get; set; default = 0x0; }
    public override string name {
        owned get {
            return mode.to_string ();
        }
    }

    public override bool require_boundaries {
        get {
            return mode == BETWEEN;
        }
    }

    public DiscreteTypeMode (DiscreteMode mode) {
        Object (mode: mode);
    }
}
