/**
* @author	chad extends work by ammon l

 */
class com.continuityny.util.SimpleDepthManager extends MovieClip{
	
///// private instance vars /////

	private var _depth:Number;

	private var _count:Number;

	private var _mcl:MovieClipLoader;

	

	private static var MAX_DEPTH:Number = 1048576; // 2^20

	

	///// public vars for listening to the mcl /////

	public var onLoadComplete:Function;

	public var onLoadError:Function;

	public var onLoadInit:Function;

	public var onLoadProgress:Function;

	public var onLoadStart:Function;

	

	///// constructor /////

	public function SimpleDepthManager() {

		// init our depth counter

		_depth = 1;

		// init our mc count, this is just for instance naming purposes

		_count = 0;

		// init our mcl

		_mcl = new MovieClipLoader();

		_mcl.addListener( this );

	}// end: constructor

	

	/**

	 * Creates and returns an empty movie clip

	 */

	public function createClip(mc_name) : MovieClip {

		validateDepth();
		
		var mc:MovieClip = this.createEmptyMovieClip( getInstanceName(), _depth );
trace("HERE IS THE NAME OF THE CLIP THAT HAS BEEN CREATED :"+mc);
		return mc;

	}// end: createClip

	

	/**

	 * Attaches a symbol from the library and returns the new instance

	 */

	public function attachClip( id:String, init:Object ) : MovieClip {

		validateDepth();

		var mc:MovieClip = this.attachMovie( id, getInstanceName(), _depth, init );
		 trace("HERE IS THE NAME OF THE CLIP THAT HAS BEEN ATTACHED :"+mc);
		return mc;

	}// end: attachClip

	

	/**

	 * Creates an empty movie clip and loads the specified clip into it.

	 */

	public function loadClip( url:String ) : MovieClip {

		var mc:MovieClip = this.createClip();

		_mcl.loadClip( url, mc );

		return mc;

	}// end: loadClip

	

	private function removeClipAt( d:Number ) : Boolean {

		var mc:MovieClip = this.getInstanceAtDepth( d );

		if( mc == undefined )

			return false;

		mc.removeMovieClip();

		// and save our new target depth

		if( d < _depth )

			_depth = d;

		return true;

	}// end: removeClipAt

	

	public function removeClip( mc:MovieClip ) : Boolean {

		if( mc._parent != this )

			return false;

		return removeClipAt( mc.getDepth() );

	}// end: removeClip

	

	/// Returns a (hopefully) unique name for the new MC to be created

	private function getInstanceName() : String {

		return "sdm_"+(++_count)+"_"+_depth;

	}// end: getInstanceName

	

	/// make sure _depth is pointing to a valid depth index

	private function validateDepth() : Void {

		var limit:Number = 1000;	// only check 1000 depths at most in one try

		var count:Number = 0;

		while( this.getInstanceAtDepth(_depth) && count < limit && _depth < MAX_DEPTH ) {

			++_depth;

			++count;

		}

		if( count == limit )

			_depth = this.getNextHighestDepth();	// fall back

		if( _depth >= MAX_DEPTH )

			throw new Error( "Unable to find a valid new depth." );

		trace( "[debug] _depth = "+_depth );

	}// end: validateDepth

}// end: class