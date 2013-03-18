
public class Test_is10086 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new Test_is10086();
	}

	public Test_is10086(){
		for(int i=130;i<200;i++){
			String phonenumber=String.valueOf(i)+"00000000";
			if(this.is10086(phonenumber)){
				System.out.println(phonenumber);
			}
		}
	}
	
	public boolean is10086(String phonenumber){

		int numberhead = Integer.parseInt(phonenumber.substring(0,3));
		switch(numberhead){
			case 134:
			case 135:
			case 136:
			case 137:
			case 138:
			case 139:
			case 150:
			case 151:
			case 152:
			case 157:
			case 158:
			case 182:
			case 183:
			case 187:
			case 188: return true;
			default: return false;
			
		}
	}

}
