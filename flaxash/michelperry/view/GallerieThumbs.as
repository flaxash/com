package com.flaxash.michelperry.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import com.greensock.TweenLite;
	
	public class GallerieThumbs extends MovieClip
	{
		public var signalClickShoe:Signal = new Signal();
		private var _couleurFond:Number = 0x81878c;
		
		public var clipTexteCollection:MovieClip;
		
		private var _nbShoes:uint;
		
		public function GallerieThumbs()
		{
			super();
		}
		public function initListeners():void {
			trace(nbShoes);
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

		public function get couleurFond():Number
		{
			return _couleurFond;
		}

		public function set couleurFond(value:Number):void
		{
			_couleurFond = value;
		}

		public function get nbShoes():uint
		{
			return _nbShoes;
		}

		public function set nbShoes(value:uint):void
		{
			_nbShoes = value;
		}

		
	}
}