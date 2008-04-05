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
			var testdata:String ="it Worked";
			var moretestdata:Array =new Array(testdata,"is an array with ",3,"tyes of data");
			
			// store it... 
			model.storeData('test1',testdata);
			model.storeData('test2',moretestdata);
			// retreive it...
			var results1:DataObject = model.getData('test1');
			var results2:DataObject = model.getData('test2');
		//	trace results 
			trace('stored data: '+results1.getData());
			trace('stored data: '+results2.getData());
			/// ;-)
		}
	}
}
