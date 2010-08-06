package com.qts.atddxmpl;

import java.io.File;
import java.util.HashMap;

public class PasswordFile {
    public PasswordFile(File source) {

    }
    
    public HashMap getAccountFromLine(String pwdFileLine) {
        String [] values = pwdFileLine.split("\t");
        HashMap<String, String> account = new HashMap<String, String>();
        account.put("name", values[0].trim());
        account.put("pwd", values[1].trim());
        account.put("status", values[2].trim());
        return account;
    }

}
