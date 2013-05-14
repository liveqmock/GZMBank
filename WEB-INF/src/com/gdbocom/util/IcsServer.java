package com.gdbocom.util;

import java.io.*;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.*;

public class IcsServer {
    private String host;
    private int post;

    public IcsServer(String host, int post){
        this.host = host;
        this.post = post;
    }

    private IcsServer(){}

    public static Map exchangeData(Map request, String host, int post) throws UnknownHostException, IOException{

        //拼包头
        //addRequestHead();
        //拼包体
        //通讯
        //取包头，判断正确与否
        //分支处理
        String context = "TLU6482150482150441800A     20130514011051 4411162T00                          00                                                                      004418003           20140320GZ_UNC  1";
        System.out.println(send(context));
        return null;
    }

    private static String send(String request) throws UnknownHostException, IOException {

        Socket sk = new Socket("182.53.15.200", 35850);
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(sk.getOutputStream()));
        BufferedReader br = new BufferedReader(new InputStreamReader(sk.getInputStream()));
        
        int length = request.length();
        bw.write(String.format("%08d", length) + request);
        bw.flush();
        return br.readLine();

    }

    private String addRequestHead(Map request){
        return null;
    }

    public String addRequestBody(){
        return null;
    }

    //public String parse
    
    public static void main(String[] args) throws Exception{
        IcsServer.exchangeData(new HashMap(), "182.53.15.200", 35850);
    }
}
