package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ben Kuper
	 */
	public class Main extends Sprite 
	{
		private var ac:AugmentaClient;
		
		public function Main() 
		{
			
			ac = new AugmentaClient();
			ac.setSafeZone(new Point(.1, .1),new Point(.9,.9));
			ac.addEventListener(AugmentaEvent.PERSON_ENTERED, personEntered);
			ac.addEventListener(AugmentaEvent.PERSON_LEFT, personLeft);
		}
		
		private function personEntered(e:AugmentaEvent):void 
		{
			trace("Person entered !",e.person.id);
			
		}
		
		private function personLeft(e:AugmentaEvent):void 
		{
			trace("Person left !",e.person.id);
		}	
	}
}