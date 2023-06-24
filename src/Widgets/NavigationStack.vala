/* NavigationStack.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Gaussian.NavigationStack : Adw.Bin {
    private Gtk.Stack view_stack = new Gtk.Stack ();

    public signal void page_selected ();

    private ListStore pages_list_store = new ListStore (typeof (Page));
    public ListModel pages_model {
        get {
            return pages_list_store;
        }
    }

    [CCode (notify=false)]
    public Page visible_page {
        get {
            return (Page) view_stack.visible_child;
        }
    }

    construct {
        add_page (new BinomialPage ());
        add_page (new ChiSquaredPage ());
        add_page (new FDistributionPage ());
        add_page (new GeometricPage ());
        add_page (new HypergeometricPage ());
        add_page (new NormalPage ());
        add_page (new PoissonPage ());
        add_page (new StudentPage ());

        child = view_stack;
    }

    public void change_visible_page (Page page, bool navigate = true) {
        view_stack.visible_child = page;
        if (navigate) {
            page_selected ();
        }
    }

    private void add_page (Page page) {
        view_stack.add_titled (page, page.tag, page.title);
        pages_list_store.append (page);
    }
}
