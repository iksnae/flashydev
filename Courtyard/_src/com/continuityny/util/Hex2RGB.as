import com.continuityny.util.Whats_inside;
/**
 * @author continuityuser
 */
class com.continuityny.util.Hex2RGB {
	public function Hex2RGB(){
	}
	public function convertHex(hex:Number):Object{
		var red:Number = hex>>16;
        var grnBlu:Number = hex-(red<<16);
        var grn:Number = grnBlu>>8;
        var blu:Number = grnBlu-(grn<<8);
        var cObj:Object = {r:red, g:grn, b:blu};
        return(cObj);
	}
}