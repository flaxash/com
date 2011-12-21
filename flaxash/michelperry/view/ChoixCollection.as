package com.flaxash.michelperry.view
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	public class ChoixCollection extends MovieClip
	{
		//sur la scène
		public var collAH2011:SimpleButton;
		public var collPE2012:SimpleButton;
		
		public var signalChoix:Signal;
		public var signalFinTransition:Signal;
		
		public function ChoixCollection()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,initListeners);
			
		}
		public function transitionOut():void {
			//
			TweenLite.to(this,1,{alpha:0,onComplete:transitionFinie});
		}
		private function initListeners(e:Event=null):void {
			signalChoix = new Signal(String);
			signalFinTransition = new Signal();
			collAH2011.addEventListener(MouseEvent.CLICK,onClick);
			collPE2012.addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onClick(me:MouseEvent):void 
		{
			switch (me.target.name) 
			{
				case "collAH2011":
					this.signalChoix.dispatch("AH2011");
					break;
				case "collPE2012":
					this.signalChoix.dispatch("PE2012");
					break;
				default:
					break;
			}
		}
		private function transitionFinie():void {
			signalFinTransition.dispatch();
		}
	}
}