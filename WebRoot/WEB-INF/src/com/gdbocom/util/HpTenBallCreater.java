package com.gdbocom.util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.gdbocom.Transactions.WelLot;
import com.gdbocom.action.wel.BetMoney;

/**
 *@author ken
 *@date 2014年12月12日 下午5:18:01
 */
public class HpTenBallCreater{
	/**
	 * 投注倍数校验正则表达式
	 */
	private static final Pattern BETMUL_PATTERN=Pattern.compile("[0-9]+");
	private static final DecimalFormat NUM_FORMAT=new DecimalFormat("00");
	private static final Map CONFIG_MAP=new HashMap();
	private HpTenParam param=null;//当前投注模式的参数

	/**
	 * 生成号码开始数
	 */
	private int startNum=1;
	/**
	 * 生成号码结束数
	 */
	private int endNum=20;
	
	public HpTenBallCreater(String buyMode) {
		if(CONFIG_MAP.isEmpty()){
			init();
		}
		//获取配置参数
		param=getParam(buyMode);
		startNum=param.start;
		endNum=param.end;
	}
	
	/**
	 * 初始化配置参数
	 */
	private void init(){
		HpTenParam p1=new HpTenParam(1, 18, 1,"选一数投");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.ONE), p1);
		
		HpTenParam p2=new HpTenParam(19,20, 1,"选一红投");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.ONE_RED), p2);
		
		HpTenParam p3=new HpTenParam(2,"任选二");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.TWO), p3);
		
		HpTenParam p4=new HpTenParam(2,"选二连直");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.TWO_LINE), p4);
		
		HpTenParam p5=new HpTenParam(2,"选二连组");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.TWO_GROUP), p5);
		
		HpTenParam p6=new HpTenParam(3,"任选三");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.THREE), p6);
		
		HpTenParam p7=new HpTenParam(3,"选三前直");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.THREE_LINE), p7);
		
		HpTenParam p8=new HpTenParam(3,"选三前组");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.THREE_GROUP), p8);
		
		HpTenParam p9=new HpTenParam(4,"任选四");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.FOUR), p9);
		
		HpTenParam p10=new HpTenParam(5,"任选五");
		CONFIG_MAP.put(String.valueOf(WelLot.HpTenBuy.FIVE), p10);
	}
	
	/**根据投注方式编码获取其参数
	 * @param mCode
	 * @return
	 */
	public HpTenParam getParam(String buyMode){
		return (HpTenParam)CONFIG_MAP.get(buyMode);
	}
	
	/**获取可用的号码
	 * @return
	 */
	public List getSelNumList(){
		List rs=new ArrayList();
		for(int i=startNum;i<=endNum;i++){
			rs.add(StringUtils.trimToEmpty(NUM_FORMAT.format(i)));
		}
		return rs;
	}
	
	public HpTenParam getParam() {
		return param;
	}
	
	/**处理选择号码数据,如果数据校验失败，将返回false
	 * @param request
	 * @return
	 */
	private static boolean processSelNum(HttpServletRequest request,HpTenParam param,int playId){
		StringBuffer sbShow=new StringBuffer();
		StringBuffer sbData=new StringBuffer();
		
		//获取显示号码组数
		String groupStr=ReqParamUtil.getParamAttr(request,"group");
		int group=Integer.parseInt(groupStr);
		//获取选择的号码
		Set nSet=new HashSet();//存放被选择号码
		Set gSet=new HashSet();//存放被选择号码所属组
		List selNums=new ArrayList();//存放被选择的号码
		String name="selNum";
		//根据需选择组数，进行特别轮询获取参数
		for(int g=1;g<=group;g++){
			String pKey=String.valueOf(g)+name;
			for(int i=0;i<21;i++){
				String v=ReqParamUtil.getParamAttr(request,pKey+String.valueOf(i));
				if(StringUtils.isNotEmpty(v)){
					selNums.add(v);
					nSet.add(v);
					gSet.add(String.valueOf(g));
				}
			}
		}
		
		String errorCode="";
		String errorStr="";
		//验证是否按规则选择号码，如果选择号码所属组数或选择号码数小于配置，都是非法
		if(gSet.size()<group||selNums.size()<param.selNum){
			errorCode="vg001";
			errorStr="请按规则选择号码";
			request.setAttribute("errorCode",errorCode);
			request.setAttribute("errorStr",errorStr);
			return false;
		}
		
		//如果所选号码与Set集合的个数不一样，说明存在重复号码
		if(selNums.size()!=nSet.size()){
			errorCode="vg001";
			errorStr="所选号码不能重复";
			request.setAttribute("errorCode",errorCode);
			request.setAttribute("errorStr",errorStr);
			return false;
		}
		
		//如果是选一红投，只能是1920
		if(playId==WelLot.HpTenBuy.ONE_RED){
			selNums=new ArrayList();
			selNums.add("19");
			selNums.add("20");
		}
		
		String sizeStr=NUM_FORMAT.format(selNums.size());
		sbData.append(sizeStr);
		Iterator iter=selNums.iterator();
		while(iter.hasNext()){
			String obj=(String) iter.next();
			sbData.append(obj);
			sbShow.append(","+obj);
		}
		String showRS=sbShow.toString().replaceFirst(",","");
		
		request.setAttribute("BetNum",sizeStr);//总号码个数
		request.setAttribute("BetLin", sbData.toString());//投注号码
		request.setAttribute("showNum",showRS);
		
		return true;
	}
	
	/**对业务数据进行处理
	 * @param request
	 * @return
	 */
	public static void processData(HttpServletRequest request,HttpServletResponse response){
		String errorCode="";
		String errorStr="";
		//获取玩法ID
		String playIdStr=ReqParamUtil.getParamAttr(request,"buyMode");
		int palyId=Integer.parseInt(playIdStr);
		
		//获取当前玩法的配置参数
		HpTenParam param=(HpTenParam) CONFIG_MAP.get(playIdStr);
		
		//表示是否通过校验
		boolean isOk=true;
		//对所选号码进行业务处理
		isOk=processSelNum(request,param,palyId);
		if(!isOk){
			//校验不通过
			toErrorPage(request, response);
			return;
		}
		
		//投注倍数
		String betMulStr=ReqParamUtil.getParamAttr(request,"BetMul");
		//如果为空或者不是正整数
		if (StringUtils.isEmpty(betMulStr)
				|| !(BETMUL_PATTERN.matcher(betMulStr).matches())) {
			errorCode="v0002";
			errorStr="投注倍数必须为正整数";
			request.setAttribute("errorCode",errorCode);
			request.setAttribute("errorStr",errorStr);
			//校验不通过
			toErrorPage(request, response);
			return;
		}
		int betMul=Integer.parseInt(betMulStr);
		
		//获取号码个数
		String betNumStr=ReqParamUtil.getParamAttr(request,"BetNum");
		int betNum=Integer.parseInt(betNumStr);
		
		//计算单复式
		int betMod=getBetMod(betNum, playIdStr,param);
		request.setAttribute("BetMod",String.valueOf(betMod));
		
		//设置默认调用参数
		setDefuCallParam(request);
		
		//计算金额
		double betAmt=calAmount(betMod, betNum, palyId, betMul, param);
		request.setAttribute("BetAmt",String.valueOf((int)betAmt*100));
		request.setAttribute("BetAmtShow",String.valueOf(betAmt));
	}

	/**
	 * 计算投注金额
	 */
	private static double calAmount(int betMod, int num, int playId,
			int betMul,HpTenParam param) {
		int betNum=param.selNum;//应投注号码个数
		int baseNum=0;//实际投注胆号码个数
		
		return new BetMoney().CalculateNMoney(playId, betMod, betMul,2,
				1, betNum, baseNum, num);
	}

	/**计算投资方式(单复式)
	 * @param numSize 号码个数
	 * @param playId 玩法编号
	 */
	private static int getBetMod(int numSize,String playId,HpTenParam param){
		int playIdInt=Integer.parseInt(playId);
		//默认单式
		int betMod=BetMoney.betMode_Single;
		//如果用户选择的个数大于应选个数，即为复式 剔除 选一红投
		if(WelLot.HpTenBuy.ONE_RED!=playIdInt&&numSize>param.selNum){
			betMod=BetMoney.betMode_Multiple;
		}
		
		return betMod;
	}
	
	public static void setDefuCallParam(HttpServletRequest request){
		String crdNo=request.getHeader("MBK_ACCOUNT");
		String buyMode = ReqParamUtil.reqParamTirm(request,"buyMode");
		request.setAttribute("BetTyp","0");//0:实时投注
		request.setAttribute("SchTyp","1");//方案类型（1：直接投注）
		request.setAttribute("SecLev","1");//方案等级（1：保密投注）
		request.setAttribute("CrdNo",crdNo);//客户银行卡号
		request.setAttribute("GameId","7");//游戏编号
		request.setAttribute("PlayId",buyMode);//玩法编号
		request.setAttribute("DrawId","");//当前大期
		request.setAttribute("KenoId","");//当前小期
		request.setAttribute("BetMet","1");//投注方法（固定填写1）
		request.setAttribute("GrpNum","1");//号码组个数
	}
	
	public static void toErrorPage(HttpServletRequest request,
			HttpServletResponse response) {
		RequestDispatcher rd = request
				.getRequestDispatcher("/errPage.jsp");
		try {
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
	
	/**
	 * 快乐十分各投注方式参数
	 */
	public class HpTenParam{
		public int start=1;//开始号码
		public int end=20;//结束号码
		public int selNum=1;//选择号码数
		public String name="";//投注方式名称
		
		public HpTenParam(int selNum,String name){
			this.selNum=selNum;
			this.name=name;
		}
		
		public HpTenParam(int start,int end,int selNum,String name){
			this.start=start;
			this.end=end;
			this.selNum=selNum;
			this.name=name;
		}
	}
}