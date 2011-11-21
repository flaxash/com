package com.flaxash.bouygues.quizz.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	public class PageGoView extends MovieClip
	{
		//sur la scene
		public var goBtn:SimpleButton;
		
		public var signalGo:Signal;
		public function PageGoView()
		{
			super();
			visible= false;
			initListeners();
		}
		
		private function initListeners():void {
			signalGo = new Signal(String);
			goBtn.addEventListener(MouseEvent.CLICK,onClickGo);
		}
		private function onClickGo(me:MouseEvent):void {
			signalGo.dispatch("goQuizz");
		}
	}
}