/* NavigationStack.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Gaussian.NavigationStack : Adw.Bin {
    private Gtk.Stack view_stack = new Gtk.Stack ();

    private ListStore pages_list_store = new ListStore (typeof (Page));
    public ListModel pages_model {
        get {
            return pages_list_store;
        }
    }

    public Page visible_page {
        get {
            return (Page) view_stack.visible_child;
        }
        set {
            view_stack.visible_child = value;
        }
    }

    construct {
        add_page (new BinomialPage ());
        add_page (new ChiSquaredPage ());
        add_page (new FDistributionPage ());
        add_page (new GeometricPage ());
        add_page (new HyperGeometricPage ());
        add_page (new NormalPage ());
        add_page (new PoissonPage ());
        add_page (new StudentPage ());
    }

    private void add_page (Page page) {
        view_stack.add_titled (page, page.tag, page.title);
        pages_list_store.append (page);
    }
}
