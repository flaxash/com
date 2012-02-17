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
	
	public class ContactPresse extends Sprite
	{
		public var couleurFond:Number = 0x81878c;
		
		public var closeBtn:SimpleButton;
		public var signalClose:Signal = new Signal();
		public var clipLogosFond:MovieClip;
		
		public function ContactPresse()
		{
			super();
			initListeners();
		}
		private function initListeners():void {
			closeBtn.addEventListener(MouseEvent.CLICK,closeContact);
		}
		public function changeLangue(langue:String):void {
			switch(langue) {
				case "fr" :
					//clipTexteAbout.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					//clipTexteAbout.gotoAndStop(2);
					trace("uk");
					break;
			}
		}
		private function closeContact(me:MouseEvent):void {
			signalClose.dispatch(Main.STATE_GALLERY);
		}


	}
}