package com.flaxash.bouygues.quizz.view.component
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import com.demonsters.debugger.MonsterDebugger;
	
	public class BoutonReponse extends MovieClip
	{
		//sur la scène
		//fond a 2 frame de couleur différente
		public var fond:MovieClip;
		public var texte:TextField;
		public var boutonVide:SimpleButton;
		
		private var textFormatNormal:TextFormat;
		private var textFormatQ2:TextFormat;
		private var textFormatQ5:TextFormat;
		private var textFormatQ26:TextFormat;
		
		public function BoutonReponse()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,initListeners);
			initTextFormats();
		}
		
		private function initTextFormats():void
		{
			textFormatNormal = new TextFormat();
			textFormatNormal.size = 27;
			textFormatQ2 = new TextFormat();
			textFormatQ2.size = 22;
			textFormatQ5 = new TextFormat();
			textFormatQ5.size = 18;
			textFormatQ26 = new TextFormat();
			textFormatQ26.size = 22;
			
		}
		public function setTexte(value:String):void {
			texte.text = value;
		}
		public function majFormat(numQuestion:uint):void {
			switch (numQuestion) {
				case 2 :
					texte.setTextFormat(textFormatQ2);
					texte.y = 3;
					break;
				case 5 :
					texte.setTextFormat(textFormatQ5);
					texte.y = 6;
					break;
				case 10 :
					texte.setTextFormat(textFormatQ26);
					texte.y = 14;
				case 26 :
					texte.setTextFormat(textFormatQ26);
					texte.y = 14;
					break;
				default :
					texte.setTextFormat(textFormatNormal);
					texte.y = 10;
					MonsterDebugger.trace(this,"defaut text format pour" +  this.name);
					break;
			}
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