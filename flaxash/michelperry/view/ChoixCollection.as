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
		public var clipVisuel:MovieClip;
		
		public var signalChoix:Signal = new Signal(String);
		public var signalFinTransition:Signal;
		
		public function ChoixCollection()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,initListeners);
		
			
		}
		public function transitionOut():void {
			//
			trace("transition out sur ChoixCollection");
			TweenLite.to(this,1,{alpha:0,onComplete:transitionFinie});
		}
		private function initListeners(e:Event=null):void {
			this.stage.addEventListener(Event.RESIZE,onResize);
			//signalChoix = new Signal(String);
			this.stop();
			signalFinTransition = new Signal();
			collAH2011.addEventListener(MouseEvent.CLICK,onClick);
			collPE2012.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onResize(event:Event):void
		{
			//clipVisuel.
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
		
		public function changeLangue(langue:String):void
		{
			// TODO Auto Generated method stub
			switch(langue) {
				case "fr" :
					this.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					this.gotoAndStop(2);
					trace("uk");
					break;
			}
			
		}
	}
}