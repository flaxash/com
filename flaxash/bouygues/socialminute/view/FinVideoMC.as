package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.osflash.signals.Signal;
	
	public class FinVideoMC extends MovieClip
	{
		//sur la scene
		public var prevenezMC:MovieClip;
		public var rejouezMC:MovieClip;
		public var recevezMC:MovieClip;
		
		public var signalReplay:Signal;
		public function FinVideoMC()
		{
			super();
			signalReplay = new Signal();
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		private function onAdded(e:Event):void {
			prevenezMC.buttonMode = true;
			rejouezMC.buttonMode = true;
			recevezMC.buttonMode = true;
			prevenezMC.addEventListener(MouseEvent.CLICK,goPrevenez);
			rejouezMC.addEventListener(MouseEvent.CLICK,goRejouez);
			recevezMC.addEventListener(MouseEvent.CLICK,goRecevez);
		}
		
		protected function goRecevez(event:MouseEvent):void
		{			
			//fonction javascript
			ExternalInterface.call("abonnement");
			
		}
		
		protected function goRejouez(event:MouseEvent):void
		{
			// dispatch signal
			signalReplay.dispatch();
		}
		
		protected function goPrevenez(event:MouseEvent):void
		{
			// fonction javascript
			ExternalInterface.call("prevenir");

			
		}
	}
}