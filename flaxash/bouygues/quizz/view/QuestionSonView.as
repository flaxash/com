package com.flaxash.bouygues.quizz.view
{
	//import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionSonVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.getDefinitionByName;
	
	public class QuestionSonView extends QuestionView
	{
		//sur la scène
		public var controlesSon:MovieClip;
		
		private var son:SoundChannel;
		
		private var extrait:Sound;
		
		public function QuestionSonView()
		{
			super();
		}
		override public function majView(value:QuestionVO):void 
		{
			super.majView(value);
			var question:QuestionSonVO = value as QuestionSonVO;
			extrait = new Sound();
			insereSon(question.nomExtrait);
			
		}
		private function insereSon(nomClasse:String):void {
			var Son:Class = getDefinitionByName(nomClasse) as Class;
			//MonsterDebugger.trace(this,Son);
			extrait = new Son();
			//MonsterDebugger.trace(this,extrait);
			initListeners();
		}
		private function initListeners():void 
		{
			controlesSon.addEventListener(MouseEvent.CLICK,startSon);
			controlesSon.gotoAndStop("play");
		}
		private function startSon(me:MouseEvent):void {
			//MonsterDebugger.trace(this,"son requested : " + extrait.length);
			controlesSon.gotoAndStop("vide");
			controlesSon.removeEventListener(MouseEvent.CLICK,startSon);
			//
			son = extrait.play();
			son.addEventListener(Event.SOUND_COMPLETE,detecteFin);
			//MonsterDebugger.trace(this,son.position);
			
		}
		private function detecteFin(e:Event):void {
			controlesSon.gotoAndStop("replay");
			controlesSon.addEventListener(MouseEvent.CLICK,replaySon);
		}
		private function replaySon(e:Event):void {
			controlesSon.gotoAndStop("vide");
			son = extrait.play();
		}
	}
}