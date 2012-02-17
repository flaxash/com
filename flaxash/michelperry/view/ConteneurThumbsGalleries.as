package com.flaxash.michelperry.view
{
	import flash.display.Sprite;
	
	import org.osflash.signals.Signal;

	
	public class ConteneurThumbsGalleries extends Sprite
	{
		
		//enfants sur la scène
		public var thumbsAH11:GallerieThumbsAH11;
		public var thumbsPE12:GallerieThumbsPE12;

		public var couleurFond:Number = 0x81878c;
		public var signalClickShoe:Signal = new Signal();

		public function ConteneurThumbsGalleries()
		{
			super();
			init();
		}
		private function init():void {
			thumbsAH11.visible = false;
			thumbsPE12.visible= true;
			thumbsAH11.signalClickShoe.add(shoeClicked);
			thumbsPE12.signalClickShoe.add(shoeClicked);
		}
		
		private function shoeClicked(nameShoe:String):void
		{
			signalClickShoe.dispatch(nameShoe);
		}
		public function changeCollection(param:String):void 
		{
			switch(param) 
			{
				case "AH2011":
					thumbsAH11.visible=true;
					thumbsPE12.visible=false;
					break;
				case "PE2012":
					thumbsAH11.visible=false;
					thumbsPE12.visible=true;
					break;
				default:
					break;
			}
			trace("conteneurThumbsGalleries collection :" + param);
		}
		public function changeLangue(langue:String):void {
			thumbsAH11.changeLangue(langue);
			thumbsPE12.changeLangue(langue);
		}
	}
}