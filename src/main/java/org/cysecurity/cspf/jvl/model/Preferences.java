package org.cysecurity.cspf.jvl.model;

import java.io.Serial;
import java.io.Serializable;

/**
 * User-interface preferences that the app round-trips through the client as a
 * serialized Java object (the "view state"). The blob is deserialized back on
 * the server, which is the sink for the insecure-deserialization demo in
 * vulnerability/deserialize/preferences.jsp (OWASP 2025 A08, CWE-502).
 */
public class Preferences implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private String theme;
    private String language;
    private int itemsPerPage;

    public Preferences() {
        this.theme = "light";
        this.language = "en";
        this.itemsPerPage = 20;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public int getItemsPerPage() {
        return itemsPerPage;
    }

    public void setItemsPerPage(int itemsPerPage) {
        this.itemsPerPage = itemsPerPage;
    }
}
