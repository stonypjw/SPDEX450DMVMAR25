public class Teenager {

	public String response;
	public Map<Integer,String> responseOptions = new Map<Integer,String>();
	private Integer num;
	
	public Teenager(){
		responseOptions.put(0,'Grunt');
		responseOptions.put(1,'Yeah');
		responseOptions.put(2,'    ');
		num = 0;
	}
	
	public String talk(String conversation){
		response = responseOptions.get(num);
		num++;
		if(num==3){num=0;}
		return response;
	}
}