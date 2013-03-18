package com.gdbocom.lottdraw;

import java.io.UnsupportedEncodingException;

/**
 * �Է���ǰ̨����ʾ��Ϣ���и�ʽ��
 * @author ������
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
	 * �����ʹ��ʳ齱���͵��н��ȼ����и�ʽ��
	 * @param drawlevel �н��ȼ�
	 * @return ��ʽ���ַ���
	 * @throws UnsupportedEncodingException
	 * @deprecated
	 */
	/*public static String getTicketDrawTips(int drawlevel) throws UnsupportedEncodingException{
		String Tips="";
		switch(drawlevel){
			case 1:{
				Tips="<label>��ϲ����<br/>�ڱ��ι��ʻ��ϲ��50Ԫ�ƶ����ѳ�ֵ��!��������ѯ��95559��</label><br/>";
				break;
			}
			case 2:{
				Tips="<label>лл���Ĳ��롣�벻Ҫ�������������ʻ��л���Ŷ��</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}*/
	
	/**
	 * ��Է��͵��н��ȼ����и�ʽ��
	 * @param drawlevel �н��ȼ�
	 * @return ��ʽ���ַ���
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
				Tips="<label>��ϲ������ϲ�񱾴λ��һ�Ƚ���ֵ5300ԪiPhone5�ֻ�������ϵ���пͷ����ġ�95559�����жҽ���</label><br/>";
				break;
			}
			case TipsShow.ACCESSIT:{
				Tips="<label>��ϲ������ϲ�񱾴λ�Ķ��Ƚ���ֵ2500ԪNew ipad������ϵ���пͷ����ġ�95559�����жҽ���</label><br/>";
				break;
			}
			case TipsShow.THIRD_CLASS:{
				Tips="<label>��ϲ������ϲ�񱾴λ�����Ƚ�20Ԫ���ѣ����г�ֵ��Ա���ڴ��ܽ����ѳ�������¼�ֻ����е��ֻ����룡</label><br/>";
				break;
			}
			case TipsShow.NONE:{
				Tips="<label>��л��һֱ�����Խ��е�֧�֣�лл���룡</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}
	
	/**
	 * ����ڳ齱����,���Ѿ����жҽ����н��ȼ����и�ʽ��
	 * @param drawlevel �н��ȼ�
	 * @return ��ʽ���ַ���
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
				Tips="<label>��ϲ������ϲ�񱾴λ��һ�Ƚ���ֵ5300ԪiPhone5�ֻ�����Ʒ�Ѿ����֡�</label><br/>";
				break;
			}
			case TipsShow.ACCESSIT:{
				Tips="<label>��ϲ������ϲ�񱾴λ�Ķ��Ƚ���ֵ2500ԪNew ipad����Ʒ�Ѿ����֡�</label><br/>";
				break;
			}
			case TipsShow.THIRD_CLASS:{
				Tips="<label>��ϲ������ϲ�񱾴λ�����Ƚ�20Ԫ���ѣ���Ʒ�Ѿ����֡�</label><br/>";
				break;
			}
			case TipsShow.NONE:{
				Tips="<label>��л��һֱ�����Խ��е�֧�֣�лл���룡</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}
	
	/**
	 * ��Է��͵��н��ȼ����ڶҽ�ҳ����и�ʽ��
	 * @param drawlevel �н��ȼ�
	 * @return ��ʽ���ַ���
	 * @throws UnsupportedEncodingException
	 * @deprecated
	 */
	/*public String getTips2(int drawlevel) throws UnsupportedEncodingException{
		String Tips="";
		switch(drawlevel){
			case 1:{
				Tips="<label>��ϲ���صȽ�����������Ա���ڶ�����Ʒ���ύ�콱����ֹ�����콱����</label><br/>";
				break;
			}
			case 2:{
				Tips="<label>��ϲ��һ�Ƚ�����������Ա���ڶ�����Ʒ���ύ�콱����ֹ�����콱����</label><br/>";
				break;
			}
			case 3:{
				Tips="<label>��ϲ�ж��Ƚ�����������Ա���ڶ�����Ʒ���ύ�콱����ֹ�����콱����</label><br/>";
				break;
			}
			case 4:{
				Tips="<label>��ϲ�����Ƚ�����������Ա���ڶ�����Ʒ���ύ�콱����ֹ�����콱����</label><br/>";
				break;
			}
			case 5:{
				Tips="<label>��л��һֱ�����Խ��е�֧�֣�лл���룡</label><br/>";
				break;
			}
			default:{
				Tips="";
			}
		}
		return new String(Tips.getBytes("UTF-8"),"UTF-8");
	}*/
}
