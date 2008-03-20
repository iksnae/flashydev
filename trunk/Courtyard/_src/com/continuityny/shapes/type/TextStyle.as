/**
 * @author Greg
 */
class com.continuityny.type.TextStyle extends TextFormat{
	
	public function TextStyle(
								_font_id:String,
								_size: Number,
								_color:Number
								)
								{
									
									
				super();
				
				//with(mainNavStyle = new TextFormat()){
				this.font = 	_font_id;
				this.size = 	_size;
				this.color = 	_color;
			}
			
									
}
	
