package com.flaxash.michelperry.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import com.greensock.TweenLite;
	
	public class GallerieThumbs extends Sprite
	{
		private var nbShoes:uint = 28;
		//boutons des shoes
		public var shoe0:MovieClip;
		public var shoe1:MovieClip;
		public var shoe2:MovieClip;
		public var shoe3:MovieClip;
		public var shoe4:MovieClip;
		public var shoe5:MovieClip;
		public var shoe6:MovieClip;
		public var shoe7:MovieClip;
		public var shoe8:MovieClip;
		public var shoe9:MovieClip;
		public var shoe10:MovieClip;
		public var shoe11:MovieClip;
		public var shoe12:MovieClip;
		public var shoe13:MovieClip;
		public var shoe14:MovieClip;
		public var shoe15:MovieClip;
		public var shoe16:MovieClip;
		public var shoe17:MovieClip;
		public var shoe18:MovieClip;
		public var shoe19:MovieClip;
		public var shoe20:MovieClip;
		public var shoe21:MovieClip;
		public var shoe22:MovieClip;
		public var shoe23:MovieClip;
		public var shoe24:MovieClip;
		public var shoe25:MovieClip;
		public var shoe26:MovieClip;
		public var shoe27:MovieClip;
		
		public var signalClickShoe:Signal = new Signal();
		public var couleurFond:Number = 0x81878c;

		public var clipTexteCollection:MovieClip;
		public function GallerieThumbs()
		{
			super();
			initListeners();
		}
		private function initListeners():void {
			for (var i:uint=0;i<nbShoes;i++) {
				var nameShoe:String = "shoe" + i;
				var myShoe:MovieClip = MovieClip(this.getChildByName(nameShoe));
				myShoe.addEventListener(MouseEvent.CLICK,clickShoe);
				myShoe.addEventListener(MouseEvent.MOUSE_OVER,onOverShoe);
				myShoe.addEventListener(MouseEvent.ROLL_OUT,onOut);
			}
			allumeAllShoes();
		}
		private function clickShoe(me:MouseEvent):void {
			trace(me.target.name);
			signalClickShoe.dispatch(me.target.name);
		}
		private function onOverShoe(me:MouseEvent):void {
			eteintAllShoes();
			TweenLite.to(me.target,1,{alpha:1});
			//me.target.alpha = 1;
		}
		private function onOut(me:MouseEvent):void {
			allumeAllShoes();
		}
		private function eteintAllShoes():void {
			for (var i:uint=0;i<nbShoes;i++) {
				var nameShoe:String = "shoe" + i;
				var myShoe:MovieClip = MovieClip(this.getChildByName(nameShoe));
				TweenLite.to(myShoe,0.5,{alpha:0.5});
				//myShoe.alpha = 0.7;
			}
		}
		private function allumeAllShoes():void {
			for (var i:uint=0;i<nbShoes;i++) {
				var nameShoe:String = "shoe" + i;
				var myShoe:MovieClip = MovieClip(this.getChildByName(nameShoe));
				TweenLite.to(myShoe,0.5,{alpha:1});
				//myShoe.alpha = 1;
			}

		}
		public function changeLangue(langue:String):void {
			switch(langue) {
				case "fr" :
					//clipTexteAbout.gotoAndStop(1);
					clipTexteCollection.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					//clipTexteAbout.gotoAndStop(2);
					clipTexteCollection.gotoAndStop(2);
					trace("uk");
					break;
			}
		}

	}
}