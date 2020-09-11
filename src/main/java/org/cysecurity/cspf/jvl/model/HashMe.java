package org.cysecurity.cspf.jvl.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author breakthesec
 */
public class HashMe {
    public static String hashMe(String str) 
    {
         StringBuffer sb=null;
        try
        {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(str.getBytes());
            byte byteData[] = md.digest();
            sb= new StringBuffer();
            for (int i = 0; i < byteData.length; i++) 
            {
             sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }   
        }
        catch(NoSuchAlgorithmException e)
        {
            
        }
        return sb.toString();
    }
}
