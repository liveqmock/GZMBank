<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="weblogic.utils.StringUtils" %>

<%
    GzLog gzLog = new GzLog("c:/gzLog_sj");
    String uri = request.getRequestURI();
    String crdNo = request.getHeader("MBK_ACCOUNT"); //银行账户
    String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
    gzLog.Write(sjNo+"进入["+uri+"]");

    //设置需要显示的值和名称,
    //String agreeText = "--协议--";
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
    <content>
        <form method='post' action='/GZMBank/SignAtOne/Gds_Qry_9901'>
            <label>请仔细阅读以下协议条款，并同意遵守条款内容:</label><br/>
            <label>《交通银行广东省分行“缴费一站通”业务委托约定》</label><br/>
            <label>本人现委托交通银行广东省分行，依照委托扣划的收费单位付款信息，扣划委托银行卡卡号内的相应款项，代理委托人缴纳相应款项。</label><br/>
            <label>1．委托人必须是指定委托银行卡持卡人，指定银行卡可以支付委托人本人和他人的已选项目的相关费用。</label><br/>
            <label>2．委托人在各渠道办理的业务委托非实时生效，请在扣款前确认签约是否已生效，否则因未及时扣款造成的欠费由委托人自负。各委托项目的自动代缴费业务功能自首次扣款成功之日起开通。因委托人在有关收费单位办理信息变更，造成无法代理缴费，由委托人自负。</label><br/>
            <label>3．委托缴费银行卡因存款余额不足或因发生挂失、冻结、结清造成无法代缴费而产生的后果，由委托人自负。</label><br/>
            <label>4．委托人不再继续履行委托项目，应及时办理撤销委托手续。否则银行将继续依据本委托书之具体内容办理代缴费手续，由此而造成的损失由委托人自负。</label><br/>
            <label>5．委托人需终止委托或因银行卡发生挂失、冻结和结清的，须及时办理撤销委托手续，具体的撤销委托手续，依据银行业务的规定办理。</label><br/>
            <label>6．委托人授权银行按照指定收费单位发送的数据从委托银行卡中扣划相应款项，银行不对指定收费单位发送的数据进行审核，对因此造成的扣划错误及延迟支付不承担任何责任。委托人对代缴的款项金额有疑问时，须向有关单位查询。委托人与银行之间委托关系仅为代理转账，相关收费单位与委托人之间的各项服务关系及由此引发的纠纷与银行无关。</label><br/>
            <label>7．鉴于代理缴费业务开展的前提为收费单位与银行存在合作关系，因此一旦有关合作关系终止，相关的代缴费服务自动终止，银行不承担任何责任。银行根据合作协议提供打印缴费发票的，发票信息自缴费之日起保留六个月。</label><br/>
            <label>8．委托缴费银行卡在同一时间发生委托支付多项费用时，委托人授权银行决定支付顺序，由此造成款项不足的滞纳金与银行无关。</label><br/>
            <label>9．本委托业务对委托人暂不收费，银行保留收取相关服务费用的权利。</label><br/>
            <label>10．委托人通过交通银行电子渠道（含个人网银、手机银行、自助通）进行缴费委托签约交易时，银行系统将会根据收费单位业务实现需要，将相关信息发送至对应的收费单位，包括：缴费银行卡号、持卡人姓名、充值或缴费金额、手机号码、身份证号、用户编号、缴费地址、订单号等。</label><br/>
            <label>11、上述规定解释权归交通银行广东省分行。</label><br/>


            <input type='submit' value='同意'/><br/>
        </form>
    </content>
</res>
