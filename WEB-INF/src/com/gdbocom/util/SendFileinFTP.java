/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.gdbocom.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPConnectionClosedException;
import org.apache.commons.net.ftp.FTPReply;

import com.viatt.util.GzLog;

/***
 * ����������ʹ�ô���ͽ����ļ�
 ***/
public class SendFileinFTP
{
	/** �����ļ�Ϊbinģʽ */
	public static final int BINARY_FILE_TYPE = 1;
	/** �����ļ�Ϊasciiģʽ */
	public static final int ASCII_FILE_TYPE = 2;
	/** ftpģʽΪ����ģʽ */
	public static final int PassiveMode = 3;
	/** ftpģʽΪ����ģʽ */
	public static final int ActiveMode = 4;
	//boolean error = false;
	/** ˽�б���FTP�ͻ��� */
	private FTPClient ftp = new FTPClient();
	GzLog gzLog = new GzLog("c:/gzLog_sj");

	/**
	 * �������������Ӻ͵�¼FTP������
	 * @param server ������IP
	 * @param username �û���
	 * @param password ����
	 * @return �Ƿ�ɹ�����
	 */
    public boolean connect(String server, String username, String password){
    	
    	//����FTP������
        try{
            int reply;
            ftp.connect(server);
            gzLog.Write("Connected to " + server + ".");

            // �������Ӻ������صķ������Ƿ���ȷ
            reply = ftp.getReplyCode();

            if (!FTPReply.isPositiveCompletion(reply)){
                ftp.disconnect();
                gzLog.Write("FTP server refused connection.");
                return false;
            }
        }catch (IOException e){//����IO�����,�Ͽ�����
            if (ftp.isConnected()){
                try{
                    ftp.disconnect();
                }catch (IOException f){
                	return false;
                }
            }
            gzLog.Write("Could not connect to server.");
            e.printStackTrace();
            return false;
        }

        //ʹ���û����������¼
        try{
            if (!ftp.login(username, password)){//��¼�����ȡ����¼
                ftp.logout();
                return false;
            }
            gzLog.Write("Remote system is " + ftp.getSystemName());

        }catch (IOException e){
            gzLog.Write(e.getMessage());
            return false;
        }
        return true;
    }
    
	/**
	 * �����������ϴ��ļ�,����ʹ���������߱���FTPģʽ��BIN����ASCII����ģʽ
	 * @param local �����ļ���(�ɰ���·��,·������ʹ��"/"���ŷָ�),�����԰�������
	 * @param remotePath Զ���ļ�·��(���Զ���ļ�����·��)
	 * @param remote Զ���ļ���(���ɰ���·��),�����԰�������
	 * @param filetype ����ģʽѡ��,��BIN��ASCII����ģʽ
	 * @param ftptype FTPģʽѡ��,�������ͱ�������ģʽ
	 * @return �Ƿ�ɹ�����
	 */
    public boolean putFile(String local, String remotePath, String remote, int filetype, int ftptype) throws IOException{

    	//ѹ���ļ�ʹ��binģʽ,��ͨ�ļ�ʹ��ASCIIģʽ
    	if (filetype==SendFileinFTP.BINARY_FILE_TYPE){
    		ftp.setFileType(FTP.BINARY_FILE_TYPE);
    		gzLog.Write("�ѽ���BIN����ģʽ");
    	}else if(filetype==SendFileinFTP.ASCII_FILE_TYPE){
    		ftp.setFileType(FTP.ASCII_FILE_TYPE);
    		gzLog.Write("�ѽ���ASCII����ģʽ");
    	}else{
    		gzLog.Write("δ֪�����ļ�����");
    		return false;
    	}
    		
        // Զ��FTP�����������װ�˷���ǽ,ͨ���Ǳ���FTPģʽ
    	if(ftptype==SendFileinFTP.ActiveMode){
    		ftp.enterLocalActiveMode();
    		gzLog.Write("�ѽ�������FTPģʽ");
    	}else if(ftptype==SendFileinFTP.PassiveMode){
    		ftp.enterLocalPassiveMode();
    		gzLog.Write("�ѽ��뱻��FTPģʽ");
    	}else{
    		ftp.enterLocalPassiveMode();
    		gzLog.Write("δ֪FTPģʽ,ʹ�ñ���FTPģʽ");
    		return false;
    	}
    
    	//�ı�Զ��Ŀ¼·��
    	ftp.changeWorkingDirectory(remotePath);
    	
    	//�ϴ��ļ���FTP������
    	try{
    		InputStream input;
            input = new FileInputStream(local);

            if(ftp.storeFile(remote, input)){
            	gzLog.Write("�ϴ�"+remote+"�ļ��ɹ�,����·��Ϊ:/"+remotePath);
            }else{
            	gzLog.Write("�ϴ��ļ�ʧ��");
            }
            input.close();

    	}catch (FTPConnectionClosedException e){
    		gzLog.Write("Server closed connection.");
            gzLog.Write(e.getMessage());
            return false;
        }
    	return true;
    }

	/**
	 * �����������ϴ��ļ�,����ʹ���������߱���FTPģʽ��BIN����ASCII����ģʽ
	 * @param local �����ļ���(�ɰ���·��,·������ʹ��"/"���ŷָ�),�����԰�������
	 * @param remotePath Զ���ļ�·��(���Զ���ļ�����·��)
	 * @param remote Զ���ļ���(���ɰ���·��),�����԰�������
	 * @param filetype ����ģʽѡ��,��BIN��ASCII����ģʽ
	 * @param ftptype FTPģʽѡ��,�������ͱ�������ģʽ
	 * @return �Ƿ�ɹ�����
	 */
    public boolean getFile(String local, String remotePath, String remote, int filetype, int ftptype) throws IOException{
    	
    	//ѹ���ļ�ʹ��binģʽ,��ͨ�ļ�ʹ��ASCIIģʽ
		if (filetype==SendFileinFTP.BINARY_FILE_TYPE){
			ftp.setFileType(FTP.BINARY_FILE_TYPE);
			gzLog.Write("�ѽ���BIN����ģʽ");
		}else if(filetype==SendFileinFTP.ASCII_FILE_TYPE){
			ftp.setFileType(FTP.ASCII_FILE_TYPE);
			gzLog.Write("�ѽ���ASCII����ģʽ");
		}else{
			gzLog.Write("δ֪�����ļ�����");
			return false;
		}
		
        // Զ��FTP�����������װ�˷���ǽ,ͨ���Ǳ���FTPģʽ
		if(ftptype==SendFileinFTP.ActiveMode){
			ftp.enterLocalActiveMode();
			gzLog.Write("�ѽ�������FTPģʽ");
		}else if(ftptype==SendFileinFTP.PassiveMode){
			ftp.enterLocalPassiveMode();
			gzLog.Write("�ѽ��뱻��FTPģʽ");
		}else{
    		ftp.enterLocalPassiveMode();
    		gzLog.Write("δ֪FTPģʽ,ʹ�ñ���FTPģʽ");
    		return false;
    	}
        
    	//�ı�Զ��Ŀ¼·��
		ftp.changeWorkingDirectory(remotePath);
		
    	//�����ļ�������
		try{
            OutputStream output;
            output = new FileOutputStream(local);
            
            if(ftp.retrieveFile(remote, output)){
            	gzLog.Write("����"+remote+"�ļ��ɹ�,����·��Ϊ:./"+local);
            }else{
            	gzLog.Write("�ϴ��ļ�ʧ��");
            }
            output.close();
            
		}catch (FTPConnectionClosedException e){
			gzLog.Write("Server closed connection.");
        	e.printStackTrace();
        	return false;
    	}
		return true;
    }
    
    /**
     * �����������˳���¼�͹ر�����
     *
     */
    public void close(){
    	
    	try{
    		ftp.logout();
    	}catch(IOException e){
    		gzLog.Write("�޷��˳���¼,������ʧЧ");
    	}
    	if (ftp.isConnected()){
            try{
                ftp.disconnect();
            }catch (IOException f){
            	gzLog.Write("�޷��ر�����,������ʧЧ");
            }
        }
    }
}