
public class test_split {

    /**
     * @param args
     */
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        
        String[] showKeys = "|session,Gds_TCusId,44101,Map,水费签约缴费号|session,Gds_TCusNm,44101,Map,水费签约缴费号|".split("\\|");
        for(int pairsIndex=0;pairsIndex<showKeys.length;pairsIndex++){
            System.out.println(showKeys[pairsIndex]);
            if("".equals(showKeys[pairsIndex])){
                continue;
            }
            String[] params = showKeys[pairsIndex].split(",");
            String source = params[0];//来源
            String key = params[1];//关键字
            String subkey = params[2];//子关键字（一般Map类型才有）
            String type = params[3];//类型
            String name = params[4];//中文名称
            String value = "";

            
        }
    }

}
