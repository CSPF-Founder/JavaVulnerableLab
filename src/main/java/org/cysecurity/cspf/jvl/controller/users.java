package org.cysecurity.cspf.jvl.controller;

public class users {
    int VerifyAdmin(String password) {
        if (!password.equals("Mew!")) {
        return(0);
        }
        //Diagnostic Mode
        return(1);
        }
}
