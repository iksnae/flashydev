/////////////////////////////////////////////
//Imports
/////////////////////////////////////////////
import mx.utils.Delegate;

import mx.controls.TextArea;
import mx.controls.ProgressBar;
import mx.controls.Button;

import flash.net.FileReference;
/////////////////////////////////////////////
	/////////////////////////////////////////////



class com.continuityny.filetransfer.UploadFile


{
	
	
	
	/////////////////////////////////////////////
	//Components
	/////////////////////////////////////////////
	//TextArea component
	private var _textArea:TextArea;
	//ProgressBar component
	private var _progressBar:ProgressBar;
	//Button components
	private var _browse_btn;
	private var _upload_btn;
	//private var _progress_mc:MovieClip;
	
	/////////////////////////////////////////////
	//FileReference object
	/////////////////////////////////////////////
	private var _fileRef:FileReference;
	/////////////////////////////////////////////
	/////////////////////////////////////////////
	
	/////////////////////////////////////////////
	//server script configured to handle upload through HTTP POST calls
	/////////////////////////////////////////////
	private static var URL:String = "./php/upload.php";

	private var TARGET_MC : MovieClip;
	
	private var onUploaded : Function; 
	
	private var this_listener : Object;	private var NEW_FILE_NAME : String;
	
	/////////////////////////////////////////////
	/////////////////////////////////////////////
	
	
	
	/////////////////////////////////////////////
	//Constructor
	/////////////////////////////////////////////
	public function UploadFile(_mc:MovieClip, onUp:Function)
	{
		TARGET_MC = _mc; 
		
		this_listener = new Object();
		
		_textArea = TARGET_MC.debug_ta;
		_browse_btn = TARGET_MC.browse_btn;
		_upload_btn = TARGET_MC.upload_btn;
		
		_progressBar = TARGET_MC.progress_mc;
		
		onUploaded = onUp; 
		
		init();
		
	}
	/////////////////////////////////////////////
	/////////////////////////////////////////////
	
	
	
	/////////////////////////////////////////////
	//onLoad
	/////////////////////////////////////////////
	private function init():Void
	{
		
		//this._textArea.fontSize = 10;

		_progressBar.mode = "manual";
		
		_fileRef = new FileReference();
		
		
		//this._browse_btn.label = "Browse";
		_browse_btn.onPress = Delegate.create(this, this.browse);
		
		_upload_btn._txt.text = "UPLOAD";
		_upload_btn.onPress = Delegate.create(this, this.upload);
		
		//this_listener.onProgress = function(fileRef:FileReference, loaded_num:Number, total_num:Number){
			//trace("imediate progress");
			// onProgress();
		//}
		
		this_listener.onProgress 	= Delegate.create(this, onUploadProgress);
		this_listener.onComplete 	= Delegate.create(this, onUploadComplete);
		this_listener.onSelect 		= Delegate.create(this, onFileSelect);
		
		_fileRef.addListener(this_listener);
		
		_progressBar.setProgress(0, 100);
		
	}
	/////////////////////////////////////////////
	/////////////////////////////////////////////


	
	/////////////////////////////////////////////
	//Button events
	/////////////////////////////////////////////
	private function browse():Void
	{
		trace("browse");
		var success:Boolean;
		
		//open OS window and specify a description for each group and the file types allowed in that group
		success = _fileRef.browse(
		[
		{description: "Image files", 	extension: "*.jpg;*.gif;*.png"	}
		]
		);
		
		//if the OS window failed to open
		if(success == false)
		{
		//	this._textArea.text += "OS window failed to open\n////////////////////////////////////////////////////////////////////////////\n\n";
			//this._textArea.vPosition = this._textArea.maxVPosition;
		}
	}
	
	
	
	private function upload():Void
	{
		trace("upload");
		var success:Boolean;
		
		var r : Number = random(90000)+10000;
		//start upload process
		success = _fileRef.upload( UploadFile.URL+"?rand_num="+ r );
		NEW_FILE_NAME  = r + "_"+_fileRef.name; 
		//if the upload process failed to start
		if(success == false)
		{
			//this._textArea.text += "upload process failed to start\n////////////////////////////////////////////////////////////////////////////\n\n";
			//this._textArea.vPosition = this._textArea.maxVPosition;
		}
	}
	/////////////////////////////////////////////
	/////////////////////////////////////////////
		
		
	
	/////////////////////////////////////////////
	//FileReference events
	/////////////////////////////////////////////
	private function onFileSelect(fileRef:FileReference):Void
	{	
		//this._textArea.text += "file selected to upload\n\n";
		//this._textArea.text += "file details\n";
		//this._textArea.text += "name: " + fileRef.name + "\n";
		trace("onFileSelect:"+fileRef.name);
		TARGET_MC.upload_txt.text = fileRef.name;
		
		//this._textArea.text += "type: " + fileRef.type + "\n";
		//this._textArea.text += "size: " + fileRef.size + "\n";
		//this._textArea.text += "creator: " + fileRef.creator + "\n";
		//this._textArea.text += "created: " + fileRef.creationDate + "\n";
		//this._textArea.text += "last modified: " + fileRef.modificationDate + "\n////////////////////////////////////////////////////////////////////////////\n\n";
		
		//this._textArea.vPosition = this._textArea.maxVPosition;
	}
	
	
	
	private function onOpen(fileRef:FileReference):Void
	{
		this._textArea.text += "upload started\n////////////////////////////////////////////////////////////////////////////\n\n";
		this._textArea.vPosition = this._textArea.maxVPosition;
	}
	
	
	
	private function onUploadProgress(fileRef:FileReference, loaded_num:Number, total_num:Number):Void {
		
		_progressBar.setProgress(loaded_num, total_num);
		
		trace("onProgress: "+loaded_num);
	}
	
	
	
	private function onUploadComplete(fileRef:FileReference):Void
	{
		trace("onUploadComplete");
		_progressBar.setProgress(100, 100);
		
		//this._textArea.text += "upload successful\n////////////////////////////////////////////////////////////////////////////\n\n";
		//this._textArea.vPosition = this._textArea.maxVPosition;
		
		onUploaded("upload/"+NEW_FILE_NAME, true);
	}
	
	public function getFileName():String{
		trace("getFileName:"+NEW_FILE_NAME);
		return NEW_FILE_NAME;	
	}
	
	private function onCancel():Void
	{
		this._textArea.text += "OS window dismissed\n////////////////////////////////////////////////////////////////////////////\n\n";
	}
	
	
	
	private function onHTTPError(fileRef:FileReference, httpError:Number):Void
	{
		this._textArea.text += "onHTTPError: " + fileRef.name + " num:"+httpError+"\n////////////////////////////////////////////////////////////////////////////\n\n";
		this._textArea.vPosition = this._textArea.maxVPosition;
	}
	
	
	
	private function onIOError(fileRef:FileReference):Void
	{
		this._textArea.text += "onIOError: " + fileRef.name + "\n////////////////////////////////////////////////////////////////////////////\n\n";
		this._textArea.vPosition = this._textArea.maxVPosition;
	}
	
	
	
	private function onSecurityError(fileRef:FileReference, error_str:String):Void
	{
		this._textArea.text += "onSecurityError: " + fileRef.name + "   error : " + error_str + "\n////////////////////////////////////////////////////////////////////////////\n\n";
		this._textArea.vPosition = this._textArea.maxVPosition;
	}
	/////////////////////////////////////////////
	/////////////////////////////////////////////



}