package com.flaxash.bouygues.quizz
{
	import com.flaxash.bouygues.quizz.model.*;
	
	import flash.display.Sprite;
	
	public class QuizzControl extends Sprite
	{
		private var gestionQuestions:GestionQuestions;
		private var gestionScore:GestionScore;
		
		public function QuizzControl()
		{
			super();
			gestionQuestions = new GestionQuestions();
			gestionScore = new GestionScore();
			initListeners();
		}
		private function initListeners():void {
			gestionQuestions.signalReady.add(questionsReady);
			gestionQuestions.getQuestions();
		}
		private function questionsReady(isReady:Boolean):void {
			if (isReady) {
				trace("questions prêtes");
				
			}
		}
	}
}