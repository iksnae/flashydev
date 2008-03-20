/**
 * @author continuityuser
 */
import flash.geom.ColorTransform;
import flash.geom.Transform;
import com.continuityny.util.Whats_inside;
class com.continuityny.util.Change_color {
	public function Change_color(clipRef:MovieClip, ctObj:ColorTransform){
		trace("Change Color: "+clipRef+" / "+ctObj);
		var trans:Transform = new Transform(clipRef);
	    trans.colorTransform = ctObj;
 	}
}