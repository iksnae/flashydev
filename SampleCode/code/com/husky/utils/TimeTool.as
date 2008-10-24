package com.husky.utils
{
	public class TimeTool
	{
		public function TimeTool()
		{
		}
		static public function generateTime(nCurrentTime:Number):String
        {
            var nMinutes:String = (Math.floor(nCurrentTime / 60) < 10 ? "0" : "") + Math.floor(nCurrentTime / 60);
            var nSeconds:String = (Math.floor(nCurrentTime % 60) < 10 ? "0" : "") + Math.floor(nCurrentTime % 60);
           
            //Set Result
            var sResult:String = nMinutes + ":" + nSeconds;
           
            //Return Value
            return sResult;
        }

	}
}