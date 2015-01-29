<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.*" %>
<!-- 分行特色业务频道列表 -->
<%

	String GNXX="0";
	/*********************************/
	request.setCharacterEncoding("UTF-8");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	
	gzLog.Write("进入["+uri+"]");
 %>
<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/zc_1.jsp"%>' >
            <table>
            <tr>
            <td>
            <label>缴费业务委托约定</label>
            </td>
            </tr>
            <tr>
            <td>
            <label>
     本人（以下称“委托人”）委托交通银行股份有限公司韶关分行（以下简称“银行”），依照收费单位通过韶关市银行电子结算中心提供的应付款信息，扣划付款账户内的款项支付给收费单位。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     1．委托人必须是指定银行的账户持有人，指定账户持有人可以支付委托人本人和他人的已选项目的相关费用。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     2．委托人在各渠道办理的业务委托非实时生效，请在扣款前确认签约是否已生效，否则因未及时扣款造成的欠费由委托人自负。各委托项目的自动代缴费业务功能自首次扣款成功之日起开通。因委托人在有关收费单位办理信息变更，造成无法扣款缴费，损失由委托人承担。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     3．因付款账户余额不足或因付款账户挂失、冻结、结清销户造成无法扣款缴费而造成的损失，由委托人承担。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     4．委托人不再继续履行委托项目，应及时至我行办理撤销委托手续，否则银行将继续依据本委托书之具体内容办理代缴费手续，由此而造成的损失由委托人自负。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     5．委托人需终止委托或因银行账户发生挂失、冻结和结清销户的，须及时办理撤销委托手续，具体的撤销委托手续，依据银行的业务规定办理。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     6. 委托人如发生委托账号变更的，需重新办理委托划扣业务，否则因此造成的损失，由委托人承担。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     7．委托人授权银行按照指定收费单位发送的数据从委托账户中扣划相应款项，银行无需对收费单位发送的数据进行审核，对因此造成的扣划错误及延迟支付不承担任何责任。委托人对代缴的款项金额有疑问时，须向收费单位查询。委托人与银行之间委托关系仅为代理转账，收费单位与委托人之间的各项服务关系及由此引发的纠纷与银行无关。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     8．鉴于代理缴费业务开展的前提为收费单位与韶关市银行电子结算中心、商业银行存在合作关系，因此一旦有关合作关系终止，相关的代缴费服务自动终止，银行不承担任何责任。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     9．同一付款账户在同一天内有多笔委托扣款缴费的，银行根据收费单位提供的应付款信息进行批量处理，扣款顺序由银行系统决定，委托人因付款账户内余额不足以支付全部扣款缴费造成的损失，由委托人承担。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     10．签订本委托时，本委托业务暂不对委托人收费。银行变更收费标准前将进行公示，若委托人不在指定时间内撤销委托，视为同意向银行支付费用以延续本委托业务。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     11.委托人通过交通银行电子渠道（含个人网银、手机银行、自助通等）进行签约交易时，银行系统将会根据韶关统一代收付平台业务实现需要，将相关信息发送至韶关统一代收付平台，包括：缴费银行卡号、持卡人姓名、缴费金额、手机号码、身份证号、缴费标识等。
  </label>
  </td>
  </tr>
  <tr>
  <td>
  <label>
     12. 因不可抗力和系统故障等意外事件的原因导致扣款不成功所造成的损失，银行不承担责任。
  </label>
 </td>
  </tr>
  <tr>
  <td>
  <label>
     13.上述规定解释权归交通银行广东省分行。
            </label>
    		</td>
    		</tr>
    		</table>
    		<input type="hidden" name="GNXX" value="<%=GNXX %>" />
    		<input type='submit' value='同意'/>
		
		</form>
	</content>
</res>
