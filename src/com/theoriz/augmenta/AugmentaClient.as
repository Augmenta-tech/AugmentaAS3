package com.theoriz.augmenta
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import org.tuio.connectors.UDPConnector;
	import org.tuio.osc.IOSCListener;
	import org.tuio.osc.OSCManager;
	import org.tuio.osc.OSCMessage;
	
	/**
	 * ...
	 * @author Ben Kuper
	 */
	public class AugmentaClient extends EventDispatcher implements IOSCListener
	{
		private var minPoint:Point;
		private var maxPoint:Point;
		
		public var activePersons:Vector.<AugmentaPerson>;
		public var oscM:OSCManager;
		
		public function AugmentaClient()
		{
			oscM = new OSCManager(new UDPConnector("0.0.0.0", 12000));
			oscM.addMsgListener(this);
			activePersons = new Vector.<AugmentaPerson>();
			
			minPoint = new Point(0, 0);
			maxPoint = new Point(1, 1);
		}
		
		/* INTERFACE org.tuio.osc.IOSCListener */
		
		public function acceptOSCMessage(msg:OSCMessage):void 
		{
			//trace(msg);
			switch(msg.address)
			{
				case "/au/personEntered" :
				case "/au/personEntered/" :
					addPerson(msg);
					break;
					
				case "/au/personWillLeave":
				case "/au/personWillLeave/":
					removePerson(msg);
					break;
					
				case "/au/personUpdated":
				case "/au/personUpdated/":
					updatePerson(msg);
					break;
					
				
			
			}
		}
		
		//data
		public function addPerson(msg:OSCMessage):AugmentaPerson
		{
			if (getPersonByID(msg.arguments[0]) != null) return null;
			
			var px:Number = msg.arguments[3];
			var py:Number = msg.arguments[4];
			if (px < minPoint.x || py < minPoint.y || px > maxPoint.x || py > maxPoint.y) return null; //safe zone
			
			var p:AugmentaPerson = new AugmentaPerson(msg);
			activePersons.push(p);
 			dispatchEvent(new AugmentaEvent(AugmentaEvent.PERSON_ENTERED,p));
			p.update(msg);
			return p;
		}
		
		public function removePerson(msg:OSCMessage):void
		{
			//var px:Number = msg.arguments[3];
			//var py:Number = msg.arguments[4];
			//if (px < minPoint.x || py < minPoint.y || px > maxPoint.x || py > maxPoint.y) return; //safe zone
			
			//trace("person Will leave received :" + msg.arguments[0]);
			var p:AugmentaPerson = getPersonByID(msg.arguments[0]);
			if (p == null) return;
			
			activePersons.splice(activePersons.indexOf(p), 1);
			
			dispatchEvent(new AugmentaEvent(AugmentaEvent.PERSON_LEFT,p));
		}
		
		public function updatePerson(msg:OSCMessage):void
		{
			var px:Number = msg.arguments[3];
			var py:Number = msg.arguments[4];
			if (px < minPoint.x || py < minPoint.y || px > maxPoint.x || py > maxPoint.y) 
			{
				removePerson(msg);
				return; //safe zone
			}
			
			var p:AugmentaPerson = getPersonByID(msg.arguments[0]);
			if (p == null)
			{
				trace("2:Person updated but doesn't exists, creating one");
				p = addPerson(msg);
			}
			p.update(msg);
		}
		
		
		//util
		public function getPersonByID(id:int):AugmentaPerson
		{
			for each(var p:AugmentaPerson in activePersons)
			{
				if (p.id == id) return p;
			}
			return null;
		}
		
		public function setSafeZone(minPoint:Point, maxPoint:Point):void 
		{
			this.maxPoint = maxPoint;
			this.minPoint = minPoint;
			
		}
		
		
	}

}