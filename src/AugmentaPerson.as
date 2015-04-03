package 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.tuio.osc.OSCMessage;
	
	/**
	 * ...
	 * @author Ben Kuper
	 */
	public class AugmentaPerson extends EventDispatcher 
	{
		public var id:int;
		public var oid:int;
		public var age:int;
		public var position:Point;
		public var width:Number;
		public var height:Number;
		public var bounds:Rectangle;
		
		public function AugmentaPerson(msg:OSCMessage) 
		{
			
			bounds = new Rectangle();
			position = new Point();
			update(msg);
		}
		
		public function update(msg:OSCMessage):void
		{
			this.id = msg.arguments[0];
			this.oid = msg.arguments[1];
			this.age = msg.arguments[2];
			this.position.x = msg.arguments[3];
			this.position.y = msg.arguments[4];
			this.bounds.x = msg.arguments[8];
			this.bounds.y = msg.arguments[8];
			this.bounds.width = msg.arguments[8];
			this.bounds.height = msg.arguments[8];
			
			dispatchEvent(new AugmentaEvent(AugmentaEvent.PERSON_UPDATE, this));
			
		}
		
	}

}