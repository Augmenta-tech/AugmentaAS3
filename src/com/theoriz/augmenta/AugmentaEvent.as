package com.theoriz.augmenta
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ben Kuper
	 */
	public class AugmentaEvent extends Event 
	{
		static public const PERSON_ENTERED:String = "personEntered";
		static public const PERSON_LEFT:String = "personLeft";
		static public const PERSON_UPDATE:String = "personUpdate";
		
		public  var person:AugmentaPerson;
		
		public function AugmentaEvent(type:String, person:AugmentaPerson, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.person = person;
			
		} 
		
		public override function clone():Event 
		{ 
			return new AugmentaEvent(type, person, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AugmentaEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}