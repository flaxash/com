package com.flaxash.michelperry.view
{
	import com.flaxash.michelperry.Main;
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class Shop extends Sprite
	{
		public var couleurFond:Number = 0x81878c;
		
		public var closeBtn:SimpleButton;
		public var clipTexteShop:MovieClip;
		public var clipLogosFond:MovieClip;
		
		public var signalClose:Signal = new Signal();

		public function Shop()
		{
			super();
			initListeners();
		}
		private function initListeners():void {
			closeBtn.addEventListener(MouseEvent.CLICK,closeShop);
		}
		public function changeLangue(langue:String):void {
			switch(langue) {
				case "fr" :
					//clipTexteAbout.gotoAndStop(1);
					clipTexteShop.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					//clipTexteAbout.gotoAndStop(2);
					clipTexteShop.gotoAndStop(2);
					trace("uk");
					break;
			}
		}
		private function closeShop(me:MouseEvent):void {
			signalClose.dispatch(Main.STATE_GALLERY);
		}

	}
}