package com.flaxash.michelperry.view
{
	import Model.VO.ShoeVO;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class Shoe extends MovieClip
	{
		public var signalClick:Signal = new Signal();
		private var pointClick:Point;
		private var globalClick:Point;
		
		public function Shoe()
		{
			super();
			trace("shoe initiallisée");
			
			initListeners();
		}
		private function initListeners():void {
			this.addEventListener(MouseEvent.CLICK,onClick);
			
		}
		private function onClick(me:MouseEvent):void {
			pointClick = new Point (this.x,this.y);
			
			trace(this.name + " : " +pointClick.x + " , " + pointClick.y);
			globalClick = this.localToGlobal(pointClick);
			trace("global : " + (globalClick.x - pointClick.x) + " , " + (globalClick.y - pointClick.y));
			var diffPosition : Point = new Point(globalClick.x - pointClick.x,globalClick.y - pointClick.y);
			signalClick.dispatch(diffPosition,this.rotation);
		}
	}
}