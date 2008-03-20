import flash.geom.*;
import flash.display.BitmapData;
import flash.filters.BlurFilter;
/**
 * @author continuityuser
 */
class com.continuityny.effects.Blur {
	
	var maxBlur:Number = 40;		// maximum blur amount for motion blurring
	var easeAmount:Number = .75;	// amount of easing to be used for movement (0-1)
	
	var TARGET_MC:MovieClip;

	function Blur(_mc:MovieClip) {
		
		TARGET_MC=_mc;
		
		// maxSize determines how large the blurred clip (click_mc)
		// could possibly get at any angle.  This is used as the size
		// of the BitmapData object that will contain the blur
		var maxSize:Number = maxBlur + Math.sqrt(TARGET_MC._width*TARGET_MC._width + TARGET_MC._height*TARGET_MC._height);
		// offset is the distance to the center of the BitmapData
		// object containing the blur.  It helps to keep centering
		var offset:Number = maxSize/2;
		
		TARGET_MC._visible = false;

		// maxSize determines how large the blurred clip (click_mc)
		// could possibly get at any angle.  This is used as the size
		// of the BitmapData object that will contain the blur
		var maxSize:Number = maxBlur + Math.sqrt(TARGET_MC._width*TARGET_MC._width + TARGET_MC._height*TARGET_MC._height);
		// offset is the distance to the center of the BitmapData
		// object containing the blur.  It helps to keep centering
		var offset:Number = maxSize/2;
		
		// create the BitmapData used for the blur based on maxSize
		var blur_bmp:BitmapData = new BitmapData(maxSize, maxSize, true, 0);
		
		// create a new clip that will act as the replacement for click_mc
		// this will use a blurred version of blur_bmp
		TARGET_MC.createEmptyMovieClip("blurredClick_mc",1);
		// blur_bmp will be attached to an interior clip, image
		// this will let the bitmap be centered within blurredClick_mc
		TARGET_MC.blurredClick_mc.createEmptyMovieClip("image",1);
		// attach blur_bmp into the image movie clip
		TARGET_MC.blurredClick_mc.image.attachBitmap(blur_bmp, 1, false, true);
		// center image in blurredClick_mc using offset
		TARGET_MC.blurredClick_mc.image._x = -offset;
		TARGET_MC.blurredClick_mc.image._y = -offset;
		
		// a matrix is needed to transform (mainly rotate) the visuals
		// of click_mc when its drawn in the image movie clip
		var rotate_matrix:Matrix = new Matrix();
		
		// BitmapData.applyFilter is used to add the blur to a rotated
		// version of click_mc as it is in blur_bmp.  The following are
		// properties relating to that call
		var blur_rect:Rectangle = blur_bmp.rectangle; // rectangle area filter affects
		var blur_point:Point = new Point(0, 0); // offset point for filter
		var blur_filter:BlurFilter = new BlurFilter(0,0); // filter (blur, starting with no power)
		
		// for movement, a point is used to represent where
		// blurredClick_mc wants to be heading
		var target_loc:Point = new Point(TARGET_MC._x, TARGET_MC._y);
		
		// FUNCTIONS
		// onEnterFrame handles bluring and movement
		TARGET_MC.onEnterFrame = function(){
			
			// get old (current) location of blurredClick_mc
			var old_loc = new Point(this.blurredClick_mc._x, this.blurredClick_mc._y);
			// develop a new location for blurredClick_mc with interpolate
			var new_loc = Point.interpolate(old_loc, target_loc, easeAmount);
			
			// assign the new_loc to the position of blurredClick_mc
			TARGET_MC.blurredClick_mc._x = new_loc.x;
			TARGET_MC.blurredClick_mc._y = new_loc.y;
			
			// get the distance from the old loc to the new
			// this will be used to determine how much blur to apply
			var distance = Point.distance(old_loc, new_loc);
			// get the angle from the old loc to the new
			// this will be used to determine the angle of the blur
			var angle = PointAngle(old_loc, new_loc);
			
						trace(old_loc+ " + "+ new_loc);
			
			// reset the rotate_matrix to remove any transformations
			// that were applied last frame
			rotate_matrix.identity();
			// rotate the matrix opposite of the angle found between
			// the new and old locations of blurredClick_mc
			rotate_matrix.rotate(-angle);
			// move the matrix by the offset to account for the
			// centered position of the original click_mc
			rotate_matrix.translate(offset, offset);
			
			// clear blur_bmp by filling it with empty pixels
			blur_bmp.fillRect(blur_bmp.rectangle, 0);
			// draw the rotated, translated click_mc into blur_bmp
			blur_bmp.draw(TARGET_MC, rotate_matrix);
			
			// apply the blur power to the blur filter
			blur_filter.blurX = Math.min(maxBlur, distance*1.5);
			// apply the blur filter to the blur_bmp
			blur_bmp.applyFilter(blur_bmp, blur_rect, blur_point, blur_filter);
			// rotate blurredClick_mc to counteract the rotation of 
			// rotate_matrix used in draw
			TARGET_MC.blurredClick_mc._rotation = angle * 180/Math.PI;
		
		};
}

// PointAngle: returns the angle between two points
function PointAngle(pt1:Point, pt2:Point):Number {
	var dx = pt2.x - pt1.x;
	var dy = pt2.y - pt1.y;
	return Math.atan2(dy, dx);
}
}