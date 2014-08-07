// Decompiled by DJ v3.10.10.93 Copyright 2007 Atanas Neshkov  Date: 2009-5-9 15:56:51
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MBSecurityUtil.java

package com.bocom.mobilebank.security;

import java.io.PrintStream;
import java.security.MessageDigest;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.*;

public class MBSecurityUtil
{

    public MBSecurityUtil()
    {
    }

    public static void main(String args[])
        throws Exception
    {
        String pwd = encryptData("60142890710180319", "KJf5T98Txpvg9fMsH164KJvQ4x5b34tRZ729FGQyVyPxgyKnb1yx!-595390905!1242111993640", "123456");
        System.out.println(pwd);
        String sourcePwd = decryptData("60142890710180319", "KJf5T98Txpvg9fMsH164KJvQ4x5b34tRZ729FGQyVyPxgyKnb1yx!-595390905!1242111993640", pwd);
        System.out.println(sourcePwd);
    }

    public static String encryptData(String accNo, String sessionId, String plantData)
        throws Exception
    {
        if(accNo == null)
            throw new Exception("accNo can not be null");
        if(sessionId == null)
            throw new Exception("sessionId can not be null");
        if(plantData == null)
        {
            throw new Exception("plant data can not be null");
        } else
        {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(("B9F1" + accNo + sessionId).getBytes());
            byte md5Key[] = md5.digest();
            javax.crypto.SecretKey key = new SecretKeySpec(md5Key, "RC4");
            Cipher cipher = Cipher.getInstance("RC4");
            cipher.init(1, key);
            byte decryptedData[] = cipher.doFinal(plantData.getBytes());
            return BASE64Encode(decryptedData);
        }
    }

    public static String decryptData(String accNo, String sessionId, String encryptedData)
        throws Exception
    {
        if(accNo == null)
            throw new Exception("accNo can not be null");
        if(sessionId == null)
            throw new Exception("sessionId can not be null");
        if(encryptedData == null)
        {
            throw new Exception("encrypted data can not be null");
        } else
        {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(("B9F1" + accNo + sessionId).getBytes());
            byte md5Key[] = md5.digest();
            javax.crypto.SecretKey key = new SecretKeySpec(md5Key, "RC4");
            Cipher cipher = Cipher.getInstance("RC4");
            cipher.init(2, key);
            byte decryptedData[] = cipher.doFinal(BASE64Decode(encryptedData));
            return new String(decryptedData);
        }
    }

    private static String BASE64Encode(byte inputData[])
    {
        return (new BASE64Encoder()).encode(inputData);
    }

    private static byte[] BASE64Decode(String inputData)
        throws Exception
    {
        return (new BASE64Decoder()).decodeBuffer(inputData);
    }
    
    static {
    	java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
    }

    private static final String a = "B9F1";
}