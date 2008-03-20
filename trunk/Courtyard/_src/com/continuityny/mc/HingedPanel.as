import com.continuityny.bitmap.ResampleImage;
import com.continuityny.text.TextLine2;
import mx.utils.Delegate;
import com.continuityny.effects.PanelOpenDistort;
/**
 * @author gregpymm
 */
class com.continuityny.mc.HingedPanel extends MovieClip {
	
	
	private var TARGET_MC:MovieClip; 
	private var BG_ID:String;
	private var DATA : Object;

	private var LOGO : ResampleImage;

	private var PANEL : PanelOpenDistort;

	private var TEXTURE_MC : MovieClip;

	private var ORIENTATION : String; 
	
	 public function HingedPanel(	_mc:MovieClip, 
	 												data:Object, 
	 												bg_id:String, 
	 												orientation:String) {
	 		
	 		super(); 
			
			TARGET_MC = _mc; 
			BG_ID = bg_id; 
			DATA = data; 
			ORIENTATION = orientation;
			
			TEXTURE_MC = TARGET_MC.attachMovie(BG_ID, "texture_mc", 1503, {_y:25, _visible:false});
			
			trace("DATA.logo_src:"+DATA.logo_src); 
			
			LOGO = new ResampleImage(TEXTURE_MC, DATA.logo_src, 100, 125); 
		
		
			var style = new TextFormat("FrutigerBold", 9, 0x357479); 
			var campaign_mc 
			= new TextLine2(TEXTURE_MC, DATA["campaign"], 200, 1, 20, style, true, true, 100).getMC(); 
			
			campaign_mc._x = 37; 
			campaign_mc._y = 96; 
			
			
			var style2 = new TextFormat("FrutigerBold", 9, 0x000000); 
			var title_mc 
			= new TextLine2(TEXTURE_MC, DATA["title"],300, 1, 20, style2, true).getMC(); 
			
			title_mc._x = 37 ;
			title_mc._y = campaign_mc._y+campaign_mc._height-4; 
			
			LOGO.getMC()._y = 28; 
			LOGO.getMC()._x = 16; 
			
			LOGO.whenLoaded = Delegate.create(this, function(){
			
				trace("when loaded ORIENTATION:"+ORIENTATION); 
				
				
					if(ORIENTATION == "right"){
				
						var _mc = 	LOGO.getMC();
						_mc._xscale = -_mc._xscale; 
						_mc._x = 160; 
						
						title_mc._xscale = -100; 
						campaign_mc._xscale = -100; 
						title_mc._x = 142; 
						campaign_mc._x = 142; 
					}
			
			
				PANEL = new PanelOpenDistort(TEXTURE_MC, ORIENTATION);
				
				PANEL.onOpen = Delegate.create(this, function(){

					TEXTURE_MC._visible = true;
				
					TARGET_MC.bmp_mc._visible = false;

					trace("O P E N : "+TEXTURE_MC._visible+" // "+TEXTURE_MC.bmp_mc._visible);
				
				});

				//TEXTURE_MC.removeMovieClip();
			
			});
		
		
		
		
		
		
		
	
	 }
	 
	 
	 public function open(){
	 	
	 		PANEL.open(); 
	 }
	 
	  public function close(){
	 		
	 		TEXTURE_MC._visible = false;
					
			TARGET_MC.bmp_mc._visible = true;
	 		
	 		PANEL.close(); 
	 }
	 
}