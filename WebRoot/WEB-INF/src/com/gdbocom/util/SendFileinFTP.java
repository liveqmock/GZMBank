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
 * 本用例用于使用传输和接收文件
 ***/
public class SendFileinFTP
{
	/** 传输文件为bin模式 */
	public static final int BINARY_FILE_TYPE = 1;
	/** 传输文件为ascii模式 */
	public static final int ASCII_FILE_TYPE = 2;
	/** ftp模式为被动模式 */
	public static final int PassiveMode = 3;
	/** ftp模式为主动模式 */
	public static final int ActiveMode = 4;
	//boolean error = false;
	/** 私有变量FTP客户端 */
	private FTPClient ftp = new FTPClient();
	GzLog gzLog = new GzLog("c:/gzLog_sj");

	/**
	 * 本方法用于连接和登录FTP服务器
	 * @param server 服务器IP
	 * @param username 用户名
	 * @param password 密码
	 * @return 是否成功连接
	 */
    public boolean connect(String server, String username, String password){
    	
    	//连接FTP服务器
        try{
            int reply;
            ftp.connect(server);
            gzLog.Write("Connected to " + server + ".");

            // 测试连接后所返回的返回码是否正确
            reply = ftp.getReplyCode();

            if (!FTPReply.isPositiveCompletion(reply)){
                ftp.disconnect();
                gzLog.Write("FTP server refused connection.");
                return false;
            }
        }catch (IOException e){//出现IO错误后,断开连接
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

        //使用用户名和密码登录
        try{
            if (!ftp.login(username, password)){//登录错误后取消登录
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
	 * 本方法用于上传文件,可以使用主动或者被动FTP模式和BIN或者ASCII传输模式
	 * @param local 本地文件名(可包括路径,路径必须使用"/"符号分隔),不可以包括中文
	 * @param remotePath 远程文件路径(添加远程文件所在路径)
	 * @param remote 远程文件名(不可包括路径),不可以包括中文
	 * @param filetype 传输模式选择,有BIN和ASCII两种模式
	 * @param ftptype FTP模式选择,有主动和被动两种模式
	 * @return 是否成功连接
	 */
    public boolean putFile(String local, String remotePath, String remote, int filetype, int ftptype) throws IOException{

    	//压缩文件使用bin模式,普通文件使用ASCII模式
    	if (filetype==SendFileinFTP.BINARY_FILE_TYPE){
    		ftp.setFileType(FTP.BINARY_FILE_TYPE);
    		gzLog.Write("已进入BIN传输模式");
    	}else if(filetype==SendFileinFTP.ASCII_FILE_TYPE){
    		ftp.setFileType(FTP.ASCII_FILE_TYPE);
    		gzLog.Write("已进入ASCII传输模式");
    	}else{
    		gzLog.Write("未知传输文件类型");
    		return false;
    	}
    		
        // 远程FTP服务器如果安装了防火墙,通常是被动FTP模式
    	if(ftptype==SendFileinFTP.ActiveMode){
    		ftp.enterLocalActiveMode();
    		gzLog.Write("已进入主动FTP模式");
    	}else if(ftptype==SendFileinFTP.PassiveMode){
    		ftp.enterLocalPassiveMode();
    		gzLog.Write("已进入被动FTP模式");
    	}else{
    		ftp.enterLocalPassiveMode();
    		gzLog.Write("未知FTP模式,使用被动FTP模式");
    		return false;
    	}
    
    	//改变远程目录路径
    	ftp.changeWorkingDirectory(remotePath);
    	
    	//上传文件到FTP服务器
    	try{
    		InputStream input;
            input = new FileInputStream(local);

            if(ftp.storeFile(remote, input)){
            	gzLog.Write("上传"+remote+"文件成功,保存路径为:/"+remotePath);
            }else{
            	gzLog.Write("上传文件失败");
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
	 * 本方法用于上传文件,可以使用主动或者被动FTP模式和BIN或者ASCII传输模式
	 * @param local 本地文件名(可包括路径,路径必须使用"/"符号分隔),不可以包括中文
	 * @param remotePath 远程文件路径(添加远程文件所在路径)
	 * @param remote 远程文件名(不可包括路径),不可以包括中文
	 * @param filetype 传输模式选择,有BIN和ASCII两种模式
	 * @param ftptype FTP模式选择,有主动和被动两种模式
	 * @return 是否成功连接
	 */
    public boolean getFile(String local, String remotePath, String remote, int filetype, int ftptype) throws IOException{
    	
    	//压缩文件使用bin模式,普通文件使用ASCII模式
		if (filetype==SendFileinFTP.BINARY_FILE_TYPE){
			ftp.setFileType(FTP.BINARY_FILE_TYPE);
			gzLog.Write("已进入BIN传输模式");
		}else if(filetype==SendFileinFTP.ASCII_FILE_TYPE){
			ftp.setFileType(FTP.ASCII_FILE_TYPE);
			gzLog.Write("已进入ASCII传输模式");
		}else{
			gzLog.Write("未知传输文件类型");
			return false;
		}
		
        // 远程FTP服务器如果安装了防火墙,通常是被动FTP模式
		if(ftptype==SendFileinFTP.ActiveMode){
			ftp.enterLocalActiveMode();
			gzLog.Write("已进入主动FTP模式");
		}else if(ftptype==SendFileinFTP.PassiveMode){
			ftp.enterLocalPassiveMode();
			gzLog.Write("已进入被动FTP模式");
		}else{
    		ftp.enterLocalPassiveMode();
    		gzLog.Write("未知FTP模式,使用被动FTP模式");
    		return false;
    	}
        
    	//改变远程目录路径
		ftp.changeWorkingDirectory(remotePath);
		
    	//下载文件到本地
		try{
            OutputStream output;
            output = new FileOutputStream(local);
            
            if(ftp.retrieveFile(remote, output)){
            	gzLog.Write("下载"+remote+"文件成功,保存路径为:./"+local);
            }else{
            	gzLog.Write("上传文件失败");
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
     * 本方法用于退出登录和关闭连接
     *
     */
    public void close(){
    	
    	try{
    		ftp.logout();
    	}catch(IOException e){
    		gzLog.Write("无法退出登录,连接已失效");
    	}
    	if (ftp.isConnected()){
            try{
                ftp.disconnect();
            }catch (IOException f){
            	gzLog.Write("无法关闭连接,连接已失效");
            }
        }
    }
}