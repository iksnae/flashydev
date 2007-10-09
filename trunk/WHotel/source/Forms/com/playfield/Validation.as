package com.playfield {
	
	import com.validation.Email;
	import com.validation.GSM;
	import flash.display.MovieClip;
	import flash.events.*;

	public class Validation extends MovieClip
	{			
		protected var emailOk:Boolean;
		protected var gsmOk:Boolean;
		
		public function Validation()
		{
			//check_btn.addEventListener("click", doValidation);
			//email_ti.tabIndex = 1;
			//phone_ti.tabIndex = 2;
			//check_btn.tabIndex = 3;
		}
		
		private function doValidation(evt:Event):void
		{
			emailOk = Email.validate(email_ti.text);
			gsmOk = GSM.validate(phone_ti.text);
			
			if(!emailOk)
			{
				trace("Invalid email address!");
				email_result.text = "Invalid email!";
			} else {
				trace("Email address is valid!");
				email_result.text = "Valid email!";
			}
			
			if (!gsmOk)
			{
				trace("Invalid cell phone number!");
				phone_result.text = "Invalid phone!";
			}
			else
			{
				trace("Cell phone number is valid!");
				phone_result.text = "Valid phone!";
			}
		}
	}
}