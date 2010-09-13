<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
  GzLog gzLog = new GzLog("c:/gzLog_sj");
  String cdno = request.getHeader("MBK_ACCOUNT");
  String sjNo = request.getHeader("MBK_MOBILE");
  gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤1");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
  <content>
    
    <form method='post' action='/GZMBank/SportsTicket/TicketSale2.jsp'>
<!-- 彩票类型-->
      <label>请选择彩票类型: </label>
      <br/>
      <input type='radio' name='LotTyp2' value='Z'>测试	</input>
      <input type='radio' name='LotTyp2' value='A'>体彩大乐透		</input>
      <input type='radio' name='LotTyp2' value='B' checked="checked">12选2			</input>
      <input type='radio' name='LotTyp2' value='C'>36选7			</input>
      <input type='radio' name='LotTyp2' value='D'>排列三			</input>
      <input type='radio' name='LotTyp2' value='E'>排列五			</input>
      <input type='radio' name='LotTyp2' value='F'>七星彩			</input>

      <!--input type='radio' name='LotTyp' value='01'>足彩胜负彩        </input-->
      <!--input type='radio' name='LotTyp' value='02'>36选7             </input-->
      <!--input type='radio' name='LotTyp' value='12'>排列3组选3        </input-->
      <!--input type='radio' name='LotTyp' value='13'>排列3组选6        </input-->
      <!--input type='radio' name='LotTyp' value='15'>排列3直选和值     </input-->
      <!--input type='radio' name='LotTyp' value='16'>排列3组选和值     </input-->
      <!--input type='radio' name='LotTyp' value='17'>排列3直选组合复式 </input-->
      <!--input type='radio' name='LotTyp' value='18'>排列3直选组合胆拖 </input-->
      <!--input type='radio' name='LotTyp' value='42'>4场进球彩         </input-->
      <!--input type='radio' name='LotTyp' value='41'>6场半全场胜负彩   </input-->
      <!--input type='radio' name='LotTyp' value='19'>足彩任选9场胜负彩 </input-->
      <!--input type='radio' name='LotTyp' value='21'>单场胜负          </input-->
      <!--input type='radio' name='LotTyp' value='22'>单场上下盘单双    </input-->
      <!--input type='radio' name='LotTyp' value='23'>单场比分          </input-->
      <!--input type='radio' name='LotTyp' value='24'>单场半全场胜负平负</input-->
      <!--input type='radio' name='LotTyp' value='25'>总进球数          </input-->
      <!--input type='radio' name='LotTyp' value='27'>体彩大乐透追加投注</input-->
      <!--input type='radio' name='LotTyp' value='28'>体彩大乐透12选2   </input-->
      <!--input type='radio' name='LotTyp' value='20'>22选5             </input-->
      
      <input type='submit' value='下一步'/>
    </form>
  </content>
</res>
