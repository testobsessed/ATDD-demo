package com.qts.atddxmpl.test;

import com.qts.atddxmpl.PasswordFile;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.mockito.Mockito.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static junit.framework.Assert.*;

public class TestPasswordFile {
    BufferedReader pwdBuffer;
    PasswordFile recordSource;
    
    @Before
    public void setUp() throws IOException {
        File pwdFile = mock(File.class);
        pwdBuffer = mock(BufferedReader.class);
        recordSource = new PasswordFile(pwdFile);
    }

    @Test
    public void getAccountFromLine() {
        HashMap accountRecord = recordSource.getAccountFromLine("fred\tpassword\tactive\n");
        assertEquals("fred", accountRecord.get("name"));
        assertEquals("password", accountRecord.get("pwd"));
        assertEquals("active", accountRecord.get("status"));
    }

  
}

