package ReflectionGalleryAPI.Decorators {	import ReflectionGalleryAPI.View.GalleryViewAbstract;		/** * @author andrehines */public class DecoratorViewAbstract extends GalleryViewAbstract {		public function DecoratorViewAbstract(theView:GalleryViewAbstract = null) {		trace("DecoratorViewAbstract class instantiated");				super(theView);	}	}}