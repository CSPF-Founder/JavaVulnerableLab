package org.cysecurity.cspf.jvl.controller;

public class users {
    int VerifyAdmin(String password) {
        if (!password.equals("Meow!")) {
        return(0);
        }

        return(1);
        }
}
