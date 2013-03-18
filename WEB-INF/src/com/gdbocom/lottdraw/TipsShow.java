package com.gdbocom.lottdraw;

import java.io.UnsupportedEncodingException;

/**
 * 对返回前台的提示信息进行格式化
 * @author 顾启明
 *
 */
public class TipsShow {
	
	public static final int OUTSTANDING = 1;
	public static final int MAJOR = 2;
	public static final int ACCESSIT = 3;
	public static final int THIRD_CLASS = 4;
	public static final int ATTENDING = 5; 
	public static final int NONE = 6;
	
	
	/**
	 * 针对体彩购彩抽奖发送的中奖等级进行格式化
	 * @param drawlevel 中奖等级
	 * @return 格式化字符串
	 * @throws UnsupportedEncodingException
	 * @deprecated
	 */
	/*public static String getTicketDrawTips(int drawlevel) throws UnsupportedEncodingException{
		String Tips="";
		switch(drawlevel){
			case 1:{
				Tips="<label>恭喜您！<br/>在本次购彩活动中喜中50元移动话费充值卡!详情请咨询“95559”</label><br/>";
				break;
			}
			case 2:{
				Tips="<label>谢谢您的参与。请不要放弃！继续购彩还有机会哦！</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}*/
	
	/**
	 * 针对发送的中奖等级进行格式化
	 * @param drawlevel 中奖等级
	 * @return 格式化字符串
	 * @throws UnsupportedEncodingException
	 */
	public static String getTips(int drawlevel) throws UnsupportedEncodingException{
		String Tips="";
		switch(drawlevel){
			case TipsShow.OUTSTANDING:{
				Tips="<label></label><br/>";
				break;
			}
			case TipsShow.MAJOR:{
				Tips="<label>恭喜您！您喜获本次活动的一等奖价值5300元iPhone5手机！请联系我行客服中心“95559”进行兑奖！</label><br/>";
				break;
			}
			case TipsShow.ACCESSIT:{
				Tips="<label>恭喜您！您喜获本次活动的二等奖价值2500元New ipad！请联系我行客服中心“95559”进行兑奖！</label><br/>";
				break;
			}
			case TipsShow.THIRD_CLASS:{
				Tips="<label>恭喜您！您喜获本次活动的三等奖20元话费！我行充值人员将于次周将话费充入您登录手机银行的手机号码！</label><br/>";
				break;
			}
			case TipsShow.NONE:{
				Tips="<label>感谢您一直以来对交行的支持，谢谢参与！</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}
	
	/**
	 * 针对在抽奖界面,且已经进行兑奖的中奖等级进行格式化
	 * @param drawlevel 中奖等级
	 * @return 格式化字符串
	 * @throws UnsupportedEncodingException
	 */
	public static String getTipsRev(int drawlevel) throws UnsupportedEncodingException{
		String Tips="";
		switch(drawlevel){
			case TipsShow.OUTSTANDING:{
				Tips="<label></label><br/>";
				break;
			}
			case TipsShow.MAJOR:{
				Tips="<label>恭喜您！您喜获本次活动的一等奖价值5300元iPhone5手机！奖品已经兑现。</label><br/>";
				break;
			}
			case TipsShow.ACCESSIT:{
				Tips="<label>恭喜您！您喜获本次活动的二等奖价值2500元New ipad！奖品已经兑现。</label><br/>";
				break;
			}
			case TipsShow.THIRD_CLASS:{
				Tips="<label>恭喜您！您喜获本次活动的三等奖20元话费！奖品已经兑现。</label><br/>";
				break;
			}
			case TipsShow.NONE:{
				Tips="<label>感谢您一直以来对交行的支持，谢谢参与！</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}
	
	/**
	 * 针对发送的中奖等级，在兑奖页面进行格式化
	 * @param drawlevel 中奖等级
	 * @return 格式化字符串
	 * @throws UnsupportedEncodingException
	 * @deprecated
	 */
	/*public String getTips2(int drawlevel) throws UnsupportedEncodingException{
		String Tips="";
		switch(drawlevel){
			case 1:{
				Tips="<label>您喜中特等奖，（由我行员工在兑现礼品后，提交领奖，防止多重领奖。）</label><br/>";
				break;
			}
			case 2:{
				Tips="<label>您喜中一等奖，（由我行员工在兑现礼品后，提交领奖，防止多重领奖。）</label><br/>";
				break;
			}
			case 3:{
				Tips="<label>您喜中二等奖，（由我行员工在兑现礼品后，提交领奖，防止多重领奖。）</label><br/>";
				break;
			}
			case 4:{
				Tips="<label>您喜中三等奖，（由我行员工在兑现礼品后，提交领奖，防止多重领奖。）</label><br/>";
				break;
			}
			case 5:{
				Tips="<label>感谢您一直以来对交行的支持，谢谢参与！</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}*/
}
