package ReflectionGalleryAPI.Controller {
	import ReflectionGalleryAPI.Controller.GalleryControllerAbstract;
	import ReflectionGalleryAPI.Model.GalleryModel;
	import ReflectionGalleryAPI.Factories.*;
	import ReflectionGalleryAPI.View.*;
	import ReflectionGalleryAPI.Events.*;
	
	import flash.utils.*;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.*;
	import flash.display.*;
	import flash.ui.Mouse;
	
	import events.XMLEvent;
	
	import ReflectionAPI.Reflection;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import fl.transitions.*;
	
	/**
 * @author andrehines
 */
public class GalleryController extends GalleryControllerAbstract {
	
	function GalleryController(){
		trace("GalleryController class instantiated");
		
		placeHolderMC.visible = false;
		
		//create the Model
    	__theModel = new GalleryModel();
    	
    	//call function to prePopulate model
    	prePopulateModel();
    	
    	//create the DEFAULT xml behavior, this can be programmed to be changed dynamically
    	this.__theXMLFactory = new XMLSimpleFactory();
    	this.__theXMLBehavior = this.__theXMLFactory.createBehavior(this.__targetXMLType, this.__targetXMLURL);
	
		//make sure the View knows the Model
		this.__theView = new GalleryView();
		this.__theView.theModel = this.__theModel;
		
		//configure the View
		this.__theView.theSectionLinkFont = this.__sectionLinkFont;
		this.__theView.imageStartingX = this.__imageStartingX;
		this.__theView.imageStartingY = this.__imageStartingY;
		this.__theView.descriptionOffset = this.__descriptionOffset;
		this.__theView.descriptionWidth = this.__descriptionWidth;
		this.__theView.connectCornerRadius = this.__connectCornerRadius;
		
		this.__theView.setup();
		
		//setup Listeners
		setupListeners();
		
		//now load shell info
		this.__theXMLBehavior.execute();	
	}
	
	// pre populates model with info
	override protected function prePopulateModel():void{
		trace("prePopulateModel function called on: " + getQualifiedClassName(this));
		
		this.__theModel.currentSectionType = this.__startingSectionType;
		this.__theModel.spacing = this.__spacing;
	}
	
	//sets up listeners
	override protected function setupListeners():void{
		trace("setupListeners function called on: " + getQualifiedClassName(this));	
		
		this.__theXMLBehavior.addEventListener(XMLEvent.PACKAGED_INFO, onPackagedInfo, false);
		this.__theView.addEventListener(ViewEvent.SECTION_CHANGED, onSectionChanged);
		this.__theView.addEventListener(ViewEvent.LINKS_READY, onLinksReady);
		this.__theView.addEventListener(ViewEvent.NEXT_SECTION, onNextSection);
		this.__theView.addEventListener(ViewEvent.PREV_SECTION, onPrevSection);
		this.__theView.addEventListener(ViewEvent.ZOOM_SECTION, onZoomSection);
		
	}
	
	//retrieves the info from the model and loads that particular section in
	override protected function getSection(sectionIndex:uint = 0):void{
		trace("getSection function called on: " + getQualifiedClassName(this));
		
		var theSections:Array = this.__theModel.sections;
		//trace("theSections: " + theSections);
		
		//iterate and find the index with the matching sectionType
		for(var i in theSections){
			if(theSections[i].type == this.__theModel.currentSectionType){
				//now check for the index that corresponds to the passed in target index to load
				//and also populate into the model
				var theURL:String = theSections[i][sectionIndex].imageURL;
				this.__theModel.currentSection = theSections[i][sectionIndex];
				this.__theModel.currentSectionIndex = sectionIndex;
				this.__theModel.currentDescription = theSections[i][sectionIndex].description;
				break;
			}
		}
		
		//now we prepare to load the section into the view
		if(this.__theLoader == null) {
			this.__theLoader = new Loader();
		}
		
		this.__theLoaderContainer = new MovieClip();
		
			
		this.__theLoaderContainer.x = this.__imageStartingX;
		this.__theLoaderContainer.y = this.__imageStartingY;
		this.__theModel.currentLoader = this.__theLoader;
		setupContentLoaderInfoListeners(this.__theLoader.contentLoaderInfo);
		
		__theURLRequest = new URLRequest(theURL);
        this.__theLoader.load(this.__theURLRequest);
		
		this.__theLoaderContainer.visible = false;
		this.__theView.addChildAt(this.__theLoaderContainer, 0);
	}
	
	// forces a link to be clicked
	override public function forceClick(targetIndex:uint):void{
		trace("forceClick function called on: " + getQualifiedClassName(this));
		trace(this.theModel.currentSectionIndex);
		this.__theModel.links[targetIndex].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
	}
	
	//configures event handling for the contentLoaderInfo dispatcher
	protected function setupContentLoaderInfoListeners(theDispatcher:IEventDispatcher):void{
		trace("setupContentLoaderInfoListeners function called on: " + getQualifiedClassName(this));
		
		theDispatcher.addEventListener(Event.COMPLETE, onLoadComplete);
       	//theDispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
        theDispatcher.addEventListener(Event.INIT, onLoadInit);
        //theDispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        theDispatcher.addEventListener(Event.OPEN, onLoadStart);
        theDispatcher.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
        //theDispatcher.addEventListener(Event.UNLOAD, onUnload);
		
	}
	
	// begins the process of revealing image, by removing first
	override protected function beginRevealImage():void{
		trace("beginRevealImage function called on: " + getQualifiedClassName(this));
		
		this.__reflectionObj = Reflection.reflect(this.__theLoaderContainer, [0, .35], [155, 255], this.__spacing, .30, .30);
		this.__reflectionObj.reflection.visible = false;
		
			//if there is an image to remove, remove it
		if(this.__reflectionOldObj == null){
			trace("No image to remove");
			
			this.__reflectionOldObj = this.__reflectionObj;
			revealImage();
		}else{
			removeImage();
		}
	}
	
	// reveals loaded image and reflects it
	override protected function revealImage():void{
		trace("revealImage function called on: " + getQualifiedClassName(this));
		
		this.__theLoaderContainer.visible = true;
		this.__reflectionObj.reflection.visible = true;
		
		this.__origTween = new Tween(this.__reflectionObj.original, "y", Back.easeOut, this.__reflectionObj.original.y + 340, this.__reflectionObj.original.y - this.__spacing, 1, true);
		this.__reflectionTween = new Tween(this.__reflectionObj.reflection, "y", Back.easeOut, this.__reflectionObj.reflection.y - 340, this.__reflectionObj.reflection.y + this.__spacing, 1, true);
	
		this.__origTween.addEventListener(TweenEvent.MOTION_FINISH, onRevealTweenFinished);
	}
	
	// removes loaded image and reflects it
	override protected function removeImage():void{
		trace("removeImage function called on: " + getQualifiedClassName(this));
		
		//set the model section changing to false
		this.__theModel.sectionChanging = true;
		
		var yToOffStage:int = 0 - this.__reflectionObj.original.height;
		var totalDistance:int = this.__reflectionObj.original.y - yToOffStage;
		
		this.__origTween = new Tween(this.__reflectionOldObj.original, "y", Back.easeIn, this.__reflectionOldObj.original.y, yToOffStage, .7, true);
		this.__reflectionTween = new Tween(this.__reflectionOldObj.reflection, "y", Back.easeIn, this.__reflectionOldObj.reflection.y, this.__reflectionOldObj.reflection.y + totalDistance, .7, true);
	
		this.__origTween.addEventListener(TweenEvent.MOTION_FINISH, onRemoveTweenFinished);
	}
	
	// swaps the regular cursor with the zoom cursor
	override public function swapZoomCursor(theBool:Boolean = false):void{
		trace("swapZoomCursor function called on: " + getQualifiedClassName(this));
		
		if(theBool){
			this.zoomCursor = new ZoomCursor();
			this.stage.addChild(this.zoomCursor);
			
			Mouse.hide();
			
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, onZoomMove);
			this.zoomCursor.addEventListener(MouseEvent.CLICK, onRemoveZoom, false);
		}else{
			this.stage.removeChild(this.zoomCursor);
			this.zoomCursor.removeEventListener(MouseEvent.CLICK, onRemoveZoom, false);
			this.zoomCursor = null;
			
			Mouse.show();
			
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onZoomMove);
		}
	}
	
	
	///////////////////////////////////// EVENTS ///////////////////////////////////////////////////
	
	// EVENT handles setting up the view when our XML info is loaded and packaged
	override public function onPackagedInfo(eventObj:XMLEvent):void{
		trace("onPackagedInfo event caught on: " + getQualifiedClassName(this));
		
		//attach the view
		this.addChild(this.__theView);
		
		//populate the model with the packaged info
		this.__theModel.sections = eventObj.packagedInfo;
		
		//also broadcast that we have packaged info
		dispatchEvent(new GalleryEvent(GalleryEvent.PACKAGED_INFO));
	}
	
	// EVENT handles making the loading animation visible whenever loading starts
	override public function onLoadStart(eventObj:Event):void{
		trace("onLoadStart event caught on: " + getQualifiedClassName(this));
		
		this.__loadAnimationMC.visible = true;
	}
	
	// EVENT handles making the loading animation invisible whenever loading completes
	override public function onLoadComplete(eventObj:Event):void{
		trace("onLoadComplete event caught on: " + getQualifiedClassName(this));
		
		this.__loadAnimationMC.visible = false;
		
		
	}
	
	// EVENT handles calling the currentPercentage function on the loading animation MovieClip
	override public function onLoadProgress(eventObj:ProgressEvent):void{
		trace("onLoadProgress event caught on: " + getQualifiedClassName(this));
		
		this.__loadAnimationMC.currentPercentage = Math.round((eventObj.bytesLoaded / eventObj.bytesTotal) * 100);
	}
	
	// EVENT handles when an image is loaded and initialized
	override public function onLoadInit(eventObj:Event):void{
		trace("onLoadInit event caught on: " + getQualifiedClassName(this));
		
		var theContent:Bitmap = new Bitmap(Bitmap(eventObj.currentTarget.content).bitmapData.clone());
		
		//create the mask
		this.__sectionMask = new MovieClip();
		
		this.__sectionMask.graphics.beginFill(0xFF0000);
        this.__sectionMask.graphics.lineStyle(0, 0xFF0000);
        this.__sectionMask.graphics.drawRoundRect(0, 0, theContent.width, theContent.height, this.__maskRoundCornerRadius, this.__maskRoundCornerRadius);
		this.__sectionMask.graphics.endFill();
		
		this.__sectionMask.cacheAsBitmap = true;
		
		//set the mask
		this.__theLoaderContainer.addChild(theContent);
		this.__theLoaderContainer.addChild(this.__sectionMask);
		theContent.cacheAsBitmap = true;
		theContent.mask = this.__sectionMask;
		this.__theLoaderContainer.cacheAsBitmap = true;
		
		// make sure the loaded bitmap is smoothed
		theContent.smoothing = true;
		
		//add button handling to loader Container
		this.__theLoaderContainer.buttonMode = true;
		this.__theLoaderContainer.addEventListener(MouseEvent.CLICK, this.__theView.onZoomClicked, false);
		
		beginRevealImage();
	}
	
	// EVENT handles when the remove tween is finished
	override public function onRemoveTweenFinished(eventObj:TweenEvent):void{
		trace("onRemoveTweenFinihsed event caught on: " + getQualifiedClassName(this));
		
		//unload previoius graphics
		this.__theView.removeChild(this.__reflectionOldObj.original);
		this.__reflectionOldObj = this.__reflectionObj;
		revealImage();
	}
	
	// EVENT handles when the remove tween is finished
	override public function onRevealTweenFinished(eventObj:TweenEvent):void{
		trace("onRevealTweenFinihsed event caught on: " + getQualifiedClassName(this));
		
		//set the model section changing to false
		this.__theModel.sectionChanging = false;
		
		//call function on the view to reveal connect
		//this.__theView.revealConnect();
	}
	
	// EVENT handles when a section link is clicked and broadcasted from the view
	override public function onSectionChanged(eventObj:ViewEvent):void{
		trace("onSectionChanged event caught on: " + getQualifiedClassName(this));
		
		getSection(eventObj.targetSection.index);
	}
	
	// EVENT handles incrementing a section index and getting the next section
	override public function onNextSection(eventObj:ViewEvent):void{
		trace("onNextSection event caught on: " + getQualifiedClassName(this));
		
		forceClick(this.__theModel.currentSectionIndex + 1);
	}
	
	// EVENT handles decrementing a section index and getting the next section
	override public function onPrevSection(eventObj:ViewEvent):void{
		trace("onPrevSection event caught on: " + getQualifiedClassName(this));
		
		forceClick(this.__theModel.currentSectionIndex - 1);
	}
	
	// EVENT handles zooming a section index and getting the next section
	override public function onZoomSection(eventObj:ViewEvent):void{
		trace("onZoomSection event caught on: " + getQualifiedClassName(this));
		
		var zoomBMD:BitmapData = Bitmap(this.__theLoader.content).bitmapData.clone();
		
		__zoomBMP = new Bitmap(zoomBMD);
		this.__zoomBMP.smoothing = true;
		
		__zoomHolder = new MovieClip();
		this.__zoomHolder.addChild(this.__zoomBMP);
		
		//add click handling
		this.__zoomHolder.buttonMode = true;
		this.__zoomHolder.addEventListener(MouseEvent.CLICK, onRemoveZoom, false);
		
		this.stage.displayState = StageDisplayState.FULL_SCREEN;
		
		//figure out which is smaller width or height of the bitmap
		var widthSmaller:Boolean = (this.__zoomHolder.width <= this.__zoomHolder.height);
		
		//now scale up to the max of either the width or height of stage
		if(widthSmaller){
			this.__zoomHolder.height = this.stage.stageHeight;
			this.__zoomHolder.scaleX = this.__zoomHolder.scaleY;
		}else{
			this.__zoomHolder.width = this.stage.stageWidth;
			this.__zoomHolder.scaleY = this.__zoomHolder.scaleX;
		}
		
		//create background
		var backgroundBMD:BitmapData = new BitmapData(this.stage.stageWidth, this.stage.stageHeight, false, 0x000000);
		var backgroundBMP = new Bitmap(backgroundBMD);
		this.__backgroundHolder = new MovieClip();
		this.__backgroundHolder.addChild(backgroundBMP);
			
		this.__backgroundHolder.x = 0 - ((this.stage.stageWidth - this.__stageWidth) / 2);
		this.__backgroundHolder.y = 0 - ((this.stage.stageHeight - this.__stageHeight) / 2);
			
		this.__backgroundHolder.addEventListener(MouseEvent.CLICK, onRemoveZoom, false);
		
		this.__zoomHolder.x = (0 - ((this.stage.stageWidth - this.__stageWidth) / 2) + ((this.stage.stageWidth / 2) - (this.__zoomHolder.width / 2)));
		this.__zoomHolder.y = (0 - ((this.stage.stageHeight - this.__stageHeight) / 2) + ((this.stage.stageHeight / 2) - (this.__zoomHolder.height / 2)));
		
		this.stage.addChild(this.__backgroundHolder);
		this.stage.addChild(this.__zoomHolder);
		
		TransitionManager.start(this.__zoomHolder, {type:Blinds, direction:Transition.IN, duration:.7, easing:Strong.easeOut, numStrips:15, dimension:0}); 
		
		//call function to swap cursor
		swapZoomCursor(true);
	}
	
	// EVENT handles removing zoom
	override public function onRemoveZoom(eventObj:MouseEvent):void{
		trace("onRemoveZoom event caught on: " + getQualifiedClassName(this));
		
		TransitionManager.start(this.__zoomHolder, {type:Blinds, direction:Transition.OUT, duration:.7, easing:Strong.easeOut, numStrips:15, dimension:0}); 
		
		this.stage.removeChild(this.__zoomHolder);
		this.__zoomHolder = null;
		this.stage.removeChild(this.__backgroundHolder);
		
		this.stage.displayState = StageDisplayState.NORMAL;
		
		//call function to swap cursor
		swapZoomCursor();
	}
	
	// EVENT handles when the links are ready in the viewe
	override public function onLinksReady(eventObj:ViewEvent):void{
		trace("onLinksReady event caught on: " + getQualifiedClassName(this));
		
		//now we decorate the view
		var viewDecorator:DecoratorSimpleFactory = new DecoratorSimpleFactory();
		this.__decoratedView = viewDecorator.createBehavior(this.__decoratorType, this.__theView);
	}
	
	// EVENT handles when the zoom cursor moves
	override public function onZoomMove(eventObj:MouseEvent):void{
		//trace("onZoomMove event caught on: " + getQualifiedClassName(this));
		
		this.zoomCursor.x = eventObj.stageX;
		this.zoomCursor.y = eventObj.stageY;
		eventObj.updateAfterEvent();
	}
	
	// EVENT handles when a fullscreen is triggered
	override public function onFullScreen(eventObj:FullScreenEvent):void{
		trace("onFullScreen event caught on: " + getQualifiedClassName(this));
		
		if (eventObj.fullScreen){
	        // Remove input text fields.
	        // Add a button that closes full-screen mode.
	    }else{
	        // Re-add input text fields.
	        // Remove the button that closes full-screen mode.
	    }
			
	}
	
}
}
