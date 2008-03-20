// FLASH IMPORTS
import mx.utils.Delegate;
// FUSE IMPORTS
import com.mosesSupposes.fuse.*;
// CONTINUITY IMPORTS
import com.continuityny.effects.ScrollingPane;
import com.continuityny.sections.*;

 /**
 * @author chad
 */
class com.continuityny.sections.FakeSection {
	
	// PUBLIC VARS
	public static var SECTION_MC:MovieClip;
	public var onClosed:Function; 
	
	// PRIVATE VARS
	private var PANEL_OBJ:Object;
	
	// CLASS VARS
	private static var scrollingLeft:ScrollingPane;
	private static var scrollingRight:ScrollingPane;
	
	
	
	public function FakeSection(_section_mc:MovieClip) {
		
		SECTION_MC = _section_mc;
		
		buildSection();
	}
	
	
	
	private static function buildSection (){
		
		// SECTION...
		var foo:Sections = new Sections (SECTION_MC, "foo" );
		
		// PANELS..
		
		// left
		var left:MovieClip = SECTION_MC.attachMovie("section_panel_REG", "left_panel_mc",SECTION_MC.getNextHighestDepth());
		var leftPanel:SectionPanel = new SectionPanel (left,"ScrollingPane","left" );
		// right
		var right:MovieClip = SECTION_MC.attachMovie("section_panel_REG", "right_panel_mc",SECTION_MC.getNextHighestDepth());
		var rightPanel:SectionPanel = new SectionPanel (right,"ScrollingPane","right" );
		
		// PANEL ELEMENTS...
	
		
	}
	
	 private function revealSection():Void{
		
		// FUSE...
	
			
	}
	
	public function resetPositions():Void{
	
		scrollingLeft.moveInterval();
		scrollingRight.moveInterval();
		
	}
	
	public function open():Void{
		
		resetPositions();
		revealSection();
		
	}
	
	public function close():Void{
	
	// FUSE...
	scrollingLeft.killInterval();
	scrollingRight.killInterval();
	
	// FINISH...
	onClosed();						
		
	}
	
	
}