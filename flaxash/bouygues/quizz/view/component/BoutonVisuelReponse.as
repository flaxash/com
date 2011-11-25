package com.flaxash.bouygues.quizz.view.component
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BoutonVisuelReponse extends MovieClip
	{
		//sur la scène:
		public var fondBoutonMC : MovieClip;
		public var boutonVide:SimpleButton;
		
		public function BoutonVisuelReponse()
		{
			super();
			//this.addEventListener(Event.ADDED_TO_STAGE,initListeners);
		}
		public function setVisuel(nomVisuel:String):void {
			fondBoutonMC.gotoAndStop(nomVisuel);
		}
		private function initListeners(e:Event):void {
			boutonVide.addEventListener(MouseEvent.ROLL_OVER,onOver);
			boutonVide.addEventListener(MouseEvent.ROLL_OUT,onOut);
		}
		
		protected function onOut(event:MouseEvent):void
		{
			
			//MonsterDebugger.trace(this,"onOut");
		}
		
		protected function onOver(event:MouseEvent):void
		{
			
		}

	}
}