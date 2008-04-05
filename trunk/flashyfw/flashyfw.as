package {
	import flash.display.Sprite;
	import com.flashydev.model.Model;
	import lt.uza.utils.Global;
	import com.flashydev.model.DataObject;

	public class flashyfw extends Sprite
	{
		private var model:Model= Model.getInstance();
		
		public function flashyfw()
		{
			// makeup some data
			var obj:String ="it Worked";
			
			// store it... 
			model.storeData('test',obj);
			// retreive it...
			var results:DataObject = model.getData('test');
		//	trace results 
			trace(results.getData());
			/// ;-)
		}
	}
}
