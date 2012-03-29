package com.flaxash.michelperry.view
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.osflash.signals.Signal;

	public class CerisesChoixCollection extends MovieClip
	{
		public var collAH2011:SimpleButton;
		public var collPE2012:SimpleButton;
		//public var clipVisuel:MovieClip;
		
		//boutons shoes cerises
		public var cerise0:MovieClip;
		public var cerise1:MovieClip;
		public var cerise2:MovieClip;
		public var cerise3:MovieClip;
		public var cerise4:MovieClip;
		public var cerise5:MovieClip;
		public var cerise6:MovieClip;
		public var cerise7:MovieClip;
		public var cerise8:MovieClip;
		public var cerise9:MovieClip;
		
		public var grosPlansCerises:MovieClip;
		
		public var pe2012:MovieClip;
		public var ah2011:MovieClip;

		
		public var signalChoix:Signal = new Signal(String);
		public var signalFinTransition:Signal;

		public function CerisesChoixCollection()
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
			initColors();
			
			collAH2011.addEventListener(MouseEvent.CLICK,onClick);
			collPE2012.addEventListener(MouseEvent.CLICK,onClick);
			for (var i:uint=0;i<10;i++) {
				var nomBouton:String = "cerise"+i;
				this.getChildByName(nomBouton).addEventListener(MouseEvent.MOUSE_OVER,onOverShoe);
				this.getChildByName(nomBouton).addEventListener(MouseEvent.ROLL_OUT,onOut);
				
			}
		}
		
		private function onOverShoe(me:MouseEvent):void {
			eteintAllShoes();
			TweenLite.to(me.currentTarget,1,{alpha:1});
			majGrosPlan(me.currentTarget.name)
		}
		private function onOut(me:MouseEvent):void {
			allumeAllShoes();
			grosPlansCerises.gotoAndStop(1);
			TweenLite.from(grosPlansCerises,0.5,{alpha:0})
		}
		private function eteintAllShoes():void {
			for (var i:uint=0;i<10;i++) {
				var nameShoe:String = "cerise" + i;
				var myShoe:MovieClip = MovieClip(this.getChildByName(nameShoe));
				TweenLite.to(myShoe,0.5,{alpha:0.5});
			}
		}
		private function allumeAllShoes():void {
			for (var i:uint=0;i<10;i++) {
				var nameShoe:String = "cerise" + i;
				var myShoe:MovieClip = MovieClip(this.getChildByName(nameShoe));
				TweenLite.to(myShoe,0.5,{alpha:1});
				//myShoe.alpha = 1;
			}
			
		}
		private function majGrosPlan(nomShoe:String):void {
			var numShoe:uint=uint(nomShoe.charAt(nomShoe.length-1));
			grosPlansCerises.gotoAndStop(numShoe+2);
			TweenLite.to(grosPlansCerises,0.5,{alpha:1});
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
					this.pe2012.gotoAndStop(1);
					this.ah2011.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					this.gotoAndStop(2);
					this.pe2012.gotoAndStop(2);
					this.ah2011.gotoAndStop(2);
					trace("uk");
					break;
			}
			
		}
		public function initColors():void {
			TweenLite.to(pe2012,0,{tint:0x000000});
			TweenLite.to(ah2011,0,{tint:0x000000});

		}
	}
}