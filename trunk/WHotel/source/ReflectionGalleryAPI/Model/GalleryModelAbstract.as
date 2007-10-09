package ReflectionGalleryAPI.Model {import flash.events.EventDispatcher;import flash.display.*;	import ReflectionGalleryAPI.Events.GalleryEvent;		/** * @author andrehines */public class GalleryModelAbstract extends EventDispatcher {		protected var __theSections:Array;	protected var __currentSection:Object;	protected var __currentLoader:Loader;	protected var __currentSectionIndex:int = -1;	protected var __currentSectionType:String;	protected var __sectionChanging:Boolean = false;	protected var __spacing:int;	protected var __currentDescription:String;	protected var __links:Array;			function GalleryModelAbstract(){		trace("GalleryModelAbstract class instantiated");		}			/////////////////////////getters and setters ///////////////////////////////		public function set sections(theArray:Array):void{		this.__theSections = theArray;				//broadcast that info was changed		dispatchEvent(new GalleryEvent(GalleryEvent.INFO_CHANGED, false, false, "sections"));	}		public function get sections():Array{		return this.__theSections;		}		public function set currentSection(theObj:Object):void{		this.__currentSection = theObj;		}		public function get currentSection():Object{		return this.__currentSection;		}		public function set currentLoader(theLoader:Loader):void{		this.__currentLoader = theLoader;		}		public function get currentLoader():Loader{		return this.__currentLoader;		}		public function set currentSectionIndex(theInt:int):void{		this.__currentSectionIndex = theInt;	}		public function get currentSectionIndex():int{		return this.__currentSectionIndex;		}		public function set currentSectionType(theString:String):void{		this.__currentSectionType = theString;					//broadcast that info was changed		dispatchEvent(new GalleryEvent(GalleryEvent.INFO_CHANGED, false, false, "sections"));	}		public function get currentSectionType():String{		return this.__currentSectionType;		}		public function set sectionChanging(theBool:Boolean):void{		this.__sectionChanging = theBool;		}		public function get sectionChanging():Boolean{		return this.__sectionChanging;		}		public function set spacing(theInt:int):void{		this.__spacing = theInt;		}		public function get spacing():int{		return this.__spacing;		}		public function set currentDescription(theString:String):void{		this.__currentDescription = theString;				//broadcast that info was changed		dispatchEvent(new GalleryEvent(GalleryEvent.INFO_CHANGED, false, false, "description"));	}		public function get currentDescription():String{		return this.__currentDescription;		}		public function set links(theArray:Array):void{		this.__links = theArray;		}		public function get links():Array{		return this.__links;		}		}}