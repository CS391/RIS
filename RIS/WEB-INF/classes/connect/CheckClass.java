package connect;

public class CheckClass {

	public CheckClass(){

	}

	/**
	 * checkClass is used to authenticate the user for the page.
	 * if the user is in the appropriate class to view the page true will
	 * be returned, otherwise false.
	 * @param module Module name
	 * 		  className Class name of the user
	 * @return true is user is able to access this page
	 * 			false otherwise
	 */
	public static boolean checkClass(String module, String className){

		//if not logged in return false
		if(className == null){
			return false;
		}
		//if doctor or patient, do not allow to the following pages
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
		//if radiologist, do not allow to the following pages
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
		//if administrator, do not allow to the following pages
		if(className.equals("a")){

			return true;
		}
		return false;
	}

}
