<%@ page import="java.util.*"%>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
<content>
<% 

System.out.println("================");

String Gds_signResult = (String)pageContext.getAttribute("Gds_signResult",
        PageContext.SESSION_SCOPE);
System.out.println("<label>Gds_signResult->"
        +(null==Gds_signResult?"null":Gds_signResult)
        +"</label>");


String Gds_GdsBIds = (String)pageContext.getAttribute("Gds_GdsBIds",
        PageContext.SESSION_SCOPE);
System.out.println("<label>Gds_GdsBIds->"
        +(null==Gds_GdsBIds?"null":Gds_GdsBIds)
        +"</label>");
if(null!=Gds_GdsBIds){
    String[] bid = Gds_GdsBIds.split(",");
    for(int i=0;i<bid.length;i++){
        System.out.println(bid[i]);
    }
}

Map business = GdsPubData.getSignBusiness();
Iterator it = business.keySet().iterator();
while(it.hasNext()){
    String businessId = (String)it.next();
    String businessName = (String)business.get(businessId);
System.out.println("<label>"+businessId+"->"+businessName+"</label>");
    

    Map Gds_TCusId = (Map)pageContext
            .getAttribute("Gds_TCusId", PageContext.SESSION_SCOPE);
    if(null!=Gds_TCusId){
        String tCusId = (String)Gds_TCusId.get(businessId);
        System.out.println("<label>Gds_TCusId->"
                +(null==tCusId?"null":tCusId)
                +"</label>");
    }
    

    Map Gds_TCusNm = (Map)pageContext
            .getAttribute("Gds_TCusNm", PageContext.SESSION_SCOPE);
    if(null!=Gds_TCusNm){
        String tCusNm = (String)Gds_TCusNm.get(businessId);
        System.out.println("<label>Gds_TCusNm->"
                +(null==tCusNm?"null":tCusNm)
                +"</label>");
    }
    

}

%>
<form method='post' action='/GZMBank/SignAtOne/Hello.jsp'>
<input type='checkbox' name='GdsBId44001' value='44001' >xxx</input><br/>
<input type='submit' value='submit'/>
</form>
</content>
</res>