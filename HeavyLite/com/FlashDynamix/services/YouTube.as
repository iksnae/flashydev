package com.FlashDynamix.services{

	import flash.events.EventDispatcher;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Dictionary;
	import com.FlashDynamix.events.YouTubeEvent;

	public class YouTube extends EventDispatcher {

		var items:Dictionary = new Dictionary();
		public var APIKey:String="WplekwLy_Nw";

		private static const servicesDomain:String = "http://code.flashdynamix.com/YouTube/";
		private static const proxyUrl:String= servicesDomain+"proxyRequest.aspx?url=";
		private static const videoIdUrl:String = servicesDomain+"getVideoId.aspx";
		/*private static const proxyUrl:String= servicesDomain+"proxyRequest.php?url=";
		private static const videoIdUrl:String = servicesDomain+"getVideoId.php";*/
		private static const watchVideoUrl:String = "http://www.youtube.com/watch?v=";
		private static const APIUrl:String="http://www.youtube.com/api2_rest";
		public static const FLVUrl:String="http://www.youtube.com/get_video?video_id=";

		private static const USERAPI:String="youtube.users.";
		private static const VIDEOAPI:String="youtube.videos.";
		
		public static  const USERFAVVIDEOS:String=USERAPI + "list_favorite_videos";
		public static  const USERPROFILE:String=USERAPI + "get_profile";
		public static  const USERFRIENDS:String=USERAPI + "list_friends";

		public static  const VIDEOSBYTAG:String=VIDEOAPI + "list_by_tag";
		public static  const VIDEOIDDETAILS:String=VIDEOAPI + "get_details";
		public static  const USERVIDEOS:String=VIDEOAPI + "list_by_user";
		public static  const FEATUREDVIDEOS:String=VIDEOAPI + "list_featured";
		public static  const VIDEOSBYCATTAG:String=VIDEOAPI + "list_by_category_and_tag";
		public static  const VIDEOSPLAYLIST:String=VIDEOAPI + "list_by_playlist";
		public static  const VIDEOID:String = "videoid";

		public function YouTube() {
		}
		private function onLoaded(e:Event):void {

			var loader:URLLoader = e.target as URLLoader;
			var request:URLRequest=items[loader];
			var xml:XML =new XML(loader.data.toString());
			
			var data:*;
			
				switch (request.data.method) {
					case USERPROFILE :
						data = xml.user_profile;
						break;
					case USERFRIENDS :
						data = xml.friend_list;
						break;
					case VIDEOIDDETAILS :
						data = xml.video_details;
						break;
					case VIDEOID :
						data = xml;
						break;
					default :
						data = xml.video_list.video;
						break;
				}
				
				
				
				var evt:YouTubeEvent = new YouTubeEvent(YouTubeEvent.COMPLETE, false, false, request.data.method);
				evt.data = data;
				evt.request = request.data;
				dispatchEvent(evt);
				
				delete items[loader];
		}
		public function get current():uint {
			var count:uint = 0;
			for each (var request:URLRequest in items) {
				count++;
			}
			return count;
		}
		private function onError(e:IOErrorEvent):void {
			trace("error");
			var loader:URLLoader = URLLoader(e.target);
			var request:URLRequest=items[loader];
			var evt:YouTubeEvent = new YouTubeEvent(ErrorEvent.ERROR, false, false, request.data.method);
			evt.request = request;
			dispatchEvent(evt);
		}
		public function videoIdDetails(id:String):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=VIDEOIDDETAILS;
			queryVars.dev_id=APIKey;
			queryVars.video_id=id;

			callService(queryVars);
		}
		public function videosbyTag(tag:String,pg:Number = 1,num:Number = 100):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=VIDEOSBYTAG;
			queryVars.dev_id=APIKey;
			queryVars.tag=tag;
			queryVars.page=pg;
			queryVars.per_page=num;

			callService(queryVars);
		}
		public function videosbyCategoryTag(tag:String,catId:Number,pg:Number =1,num:Number = 100):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=VIDEOSBYCATTAG;
			queryVars.dev_id=APIKey;
			queryVars.category_id=catId;
			queryVars.tag=tag;
			queryVars.page=pg;
			queryVars.per_page=100;

			callService(queryVars);
		}
		public function userFavouriteVideos(user:String):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=USERFAVVIDEOS;
			queryVars.dev_id=APIKey;
			queryVars.user=user;

			callService(queryVars);
		}
		public function userProfile(user:String):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=USERPROFILE;
			queryVars.dev_id=APIKey;
			queryVars.user=user;

			callService(queryVars);
		}
		public function userFriends(user:String):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=USERFRIENDS;
			queryVars.dev_id=APIKey;
			queryVars.user=user;

			callService(queryVars);
		}
		public function userVideos(user:String, pg:Number = 1, num:Number = 100):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=USERVIDEOS;
			queryVars.dev_id=APIKey;
			queryVars.user=user;
			queryVars.page=pg;
			queryVars.per_page=num;

			callService(queryVars);
		}
		public function featuredVideos(user:String) {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=FEATUREDVIDEOS;
			queryVars.dev_id=APIKey;

			callService(queryVars);
		}
		public function videosPlaylist(id:String,pg:Number = 1,num:Number = 100):void {

			var queryVars:URLVariables=new URLVariables();
			queryVars.method=VIDEOSPLAYLIST;
			queryVars.dev_id=APIKey;
			queryVars.id=id;
			queryVars.page=pg;
			queryVars.per_page=num;

			callService(queryVars);
		}
		public function getVideoId(id:String){
			var request:URLRequest=new URLRequest(videoIdUrl);
			
			var queryVars:URLVariables=new URLVariables();
			queryVars.method = VIDEOID;
			queryVars.url = watchVideoUrl+id
			request.data = queryVars;
			request.method = "GET";
			
			var loader:URLLoader=new URLLoader(request);
			loader.dataFormat = URLLoaderDataFormat.TEXT;

			loader.addEventListener(Event.COMPLETE,onLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			
			trace("called");

			try {
				items[loader] = request;
				loader.load(request);
			} catch (e:Error) {
				trace("Could not load URL");
			}
			
		}
		private function callService(queryVars:URLVariables):void {

			var request:URLRequest=new URLRequest(proxyUrl + APIUrl);
			request.data = queryVars;
			request.method = "POST";

			var loader:URLLoader=new URLLoader(request);
			loader.dataFormat = URLLoaderDataFormat.TEXT;

			loader.addEventListener(Event.COMPLETE,onLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			
			try {
				items[loader] = request;
				loader.load(request);
			} catch (e:Error) {
				trace("Could not load URL");
			}
		}
	}
}