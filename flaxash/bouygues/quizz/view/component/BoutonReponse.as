package com.flaxash.bouygues.quizz.view.component
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.demonsters.debugger.MonsterDebugger;
	public class BoutonReponse extends MovieClip
	{
		//sur la scène
		//fond a 2 frame de couleur différente
		public var fond:MovieClip;
		public var texte:TextField;
		public var boutonVide:SimpleButton;
		
		public function BoutonReponse()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,initListeners);
		}
		public function setTexte(value:String):void {
			texte.text = value;
		}
		private function initListeners(e:Event):void {
			boutonVide.addEventListener(MouseEvent.ROLL_OVER,onOver);
			boutonVide.addEventListener(MouseEvent.ROLL_OUT,onOut);
		}
		
		protected function onOut(event:MouseEvent):void
		{
			fond.gotoAndStop(1);
			texte.textColor = 0xCE0080;
			//MonsterDebugger.trace(this,"onOut");
		}
		
		protected function onOver(event:MouseEvent):void
		{
			fond.gotoAndStop(2);
			texte.textColor = 0xFFFFFF;
		}
		
	}
}