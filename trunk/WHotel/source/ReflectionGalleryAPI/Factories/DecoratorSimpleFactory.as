package ReflectionGalleryAPI.Factories{

import ReflectionGalleryAPI.Decorators.*;
import flash.utils.*;
import ReflectionGalleryAPI.View.*;
	
/**
 * @author andrehines
 * @version 1.0
 * @created 06-Aug-2007 4:56:19 PM
 */

public class DecoratorSimpleFactory{

	function DecoratorSimpleFactory(){
		trace("DecoratorSimpleFactory class instantiated");
	}

    public function createBehavior(theType:String, theTarget:GalleryViewAbstract):DecoratorViewAbstract{
		trace("createBehavior function called on: " + getQualifiedClassName(this));

		var theBehavior:DecoratorViewAbstract;

		if(theType == "WGalleryDecorator"){
			theBehavior = new WGalleryDecorator(theTarget);
		}else{
			trace("WARNING: no behavior type defined on: " + getQualifiedClassName(this));
		}

		return theBehavior;
    }

}//end XMLSimpleFactory

}