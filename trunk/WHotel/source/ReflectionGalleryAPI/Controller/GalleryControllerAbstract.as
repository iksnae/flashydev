package ReflectionGalleryAPI.Controller {
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.*;
	import fl.transitions.TweenEvent;
	import fl.transitions.Tween;
	import flash.events.FullScreenEvent;
	
	
	import ReflectionGalleryAPI.Model.*;
	import ReflectionGalleryAPI.View.*;
	import ReflectionGalleryAPI.Behaviors.XMLBehaviorAbstract;
	import ReflectionGalleryAPI.Factories.XMLSimpleFactory;
	import ReflectionGalleryAPI.Events.*;
	import ReflectionGalleryAPI.Decorators.*;
	
	import events.XMLEvent;
	
	/**
 * @author andrehines
 */
public class GalleryControllerAbstract extends MovieClip {
	
	internal var __theModel:GalleryModel;
    internal var __theView:GalleryView;
	internal var __theXMLBehavior:XMLBehaviorAbstract;
	internal var __theXMLFactory:XMLSimpleFactory;
	internal var __theURLRequest:URLRequest;
	internal var __theLoader:Loader;
	internal var __theLoaderContainer:MovieClip;
	internal var __loadAnimationMC:MovieClip;
	internal var __reflectionObj:Object;
	internal var __reflectionOldObj:Object;
	internal var __origTween:Tween;
	internal var __reflectionTween:Tween;
	internal var __zoomBMP:Bitmap;
	internal var __zoomHolder:MovieClip;
	internal var __decoratedView:DecoratorViewAbstract;
	internal var __sectionMask:MovieClip;
	protected var __backgroundHolder:MovieClip;
	
	public var placeHolderMC:MovieClip;
	public var zoomCursor:ZoomCursor;
	
	//[Inspectable(name="1. Target XML Behavior Type", defaultValue="CollegeFestXML", type=String)]
    protected var __targetXMLType:String = "WGalleryXML";

    //[Inspectable(name="2. Target XML URL", defaultValue="navigation.xml", type=String)]
    protected var __targetXMLURL:String = "residencesFurnished/gallery.xml";

    //[Inspectable(name="3. Target Decorator Type", defaultValue="TradeBlazerDecorator", type=String)]
    protected var __decoratorType:String = "WGalleryDecorator";
    protected var __imageStartingX:int = 306;
    protected var __imageStartingY:int = 130;
    protected var __spacing:int = 15;
    protected var __sectionLinkFont:String = "Gill Sans Std";
    protected var __startingSectionType:String = "Residences";
    protected var __stageWidth:int = 960;
    protected var __stageHeight:int = 578;
    protected var __descriptionOffset:int = 90;
    protected var __descriptionWidth:int = 160;
    protected var __connectCornerRadius:int = 15;
    protected var __maskRoundCornerRadius:uint = 60;
	
	function GalleryControllerAbstract(){
		trace("GalleryControllerAbstract class instantiated");	
	}
	
	//sets up listeners
	protected function setupListeners():void{
	}
	
	//retrieves the info from the model and loads that particular section in
	protected function getSection(sectionIndex:uint = 0):void{
	}
	
	// begins the process of revealing image, by removing first
	protected function beginRevealImage():void{	
	}
	
	// reveals loaded image and reflects it
	protected function revealImage():void{
	}
	
	// removes loaded image and reflects it
	protected function removeImage():void{
	}
	
	// pre populates model with info
	protected function prePopulateModel():void{
	}
	
	// forces a link to be clicked
	public function forceClick(targetIndex:uint):void{
	}
	
	// swaps the regular cursor with the zoom cursor
	public function swapZoomCursor(theBool:Boolean = false):void{
	}
	
	
	///////////////////////////////////// EVENTS ///////////////////////////////////////////////////
	
	//handles setting up the view when our XML info is loaded and packaged
	public function onPackagedInfo(eventObj:XMLEvent):void{
	}
	
	// EVENT handles making the loading animation visible whenever loading starts
	public function onLoadStart(eventObj:Event):void{
	}
	
	// EVENT handles making the loading animation invisible whenever loading completes
	public function onLoadComplete(eventObj:Event):void{
	}
	
	// EVENT handles calling the currentPercentage function on the loading animation MovieClip
	public function onLoadProgress(eventObj:ProgressEvent):void{
	}
	
	// EVENT handles when an image is loaded and initialized
	public function onLoadInit(eventObj:Event):void{	
	}
	
	// EVENT handles when the remove tween is finished
	public function onRemoveTweenFinished(eventObj:TweenEvent):void{
	}
	
	// EVENT handles when the reveal tween is finished
	public function onRevealTweenFinished(eventObj:TweenEvent):void{
	}
	
	// EVENT handles when a section link is clicked and broadcasted from the view
	public function onSectionChanged(eventObj:ViewEvent):void{
	}
	
	// EVENT handles incrementing a section index and getting the next section
	public function onNextSection(eventObj:ViewEvent):void{
	}
	
	// EVENT handles decrementing a section index and getting the next section
	public function onPrevSection(eventObj:ViewEvent):void{
	}
	
	// EVENT handles zooming a section index and getting the next section
	public function onZoomSection(eventObj:ViewEvent):void{
	}
	
	// EVENT handles removing zoom
	public function onRemoveZoom(eventObj:MouseEvent):void{
	}
	
	// EVENT handles when the links are ready in the viewe
	public function onLinksReady(eventObj:ViewEvent):void{
	}
	
	// EVENT handles when the zoom cursor moves
	public function onZoomMove(eventObj:MouseEvent):void{
	}
	
	// EVENT handles when a fullscreen is triggered
	public function onFullScreen(eventObj:FullScreenEvent):void{
	}
	
	
	////////////////////////// getters and setters //////////////////////////////////////////
	
	public function set loadAnimationMC(theMC:MovieClip):void{
		this.__loadAnimationMC = theMC;	
	}
	
	public function get currentLoader():Loader{
		return this.__theModel.currentLoader;	
	}
	
	public function get theModel():GalleryModelAbstract{
		return this.__theModel;
	}
	
	public function set currentSectionType(theString:String):void{
		this.__theModel.currentSectionType = theString;	
	}
	
	public function get currentSectionType():String{
		return this.__theModel.currentSectionType;	
	}
	
}
}
