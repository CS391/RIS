package connect;

public class CheckClass {

	public CheckClass(){

	}

	public static boolean checkClass(String module, String className){

		if(className == null){
			return false;
		}
		if(className.equals("p") || className.equals("d")){
			if(module.equals("user_management")){
				return false;
			}
			if(module.equals("report_generating")){
				return false;
			}
			if(module.equals("uploading")){
				return false;
			}
			if(module.equals("data_analysis")){
				return false;
			}
		}
		else{
			return true;
		}
		if(className.equals("r")){
			if(module.equals("user_management")){
				return false;
			}
			if(module.equals("report_generating")){
				return false;
			}
			if(module.equals("data_analysis")){
				return false;
			}
		}
		else{
			return true;
		}
		if(className.equals("a")){
			if(module.equals("uploading")){
				return false;
			}
		}
		else{
			return true;
		}
		return false;
	}

}
