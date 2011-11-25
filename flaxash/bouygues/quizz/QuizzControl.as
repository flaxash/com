package com.flaxash.bouygues.quizz
{
	import com.flaxash.bouygues.quizz.model.*;
	import com.flaxash.bouygues.quizz.model.VO.*;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyGetInitVars;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyGetQuizz;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyLoaderQuestions;
	
	import flash.display.Sprite;
	
	import org.osflash.signals.Signal;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	public class QuizzControl extends Sprite
	{
		private var gestionQuestions:GestionQuestions;
		private var gestionScore:GestionScore;
		private var loaderInitVars:ProxyGetInitVars;
		private var loaderQuizz:ProxyGetQuizz;
		private var loadingsTraites:uint=0;
		
		public var listeQuestionsChoisies:Array;
		public var allQuestions:Array;
		
		public var signalReady:Signal;
		public var signalReponse:Signal;
		public var step:uint;
		public var score:uint;
		
		public function QuizzControl()
		{
			super();
			signalReady = new Signal(Boolean);
			signalReponse = new Signal(XML);
			
		}
		public function init():void {
			gestionQuestions = new GestionQuestions();
			gestionScore = new GestionScore();
			loaderInitVars = new ProxyGetInitVars();
			loaderQuizz = new ProxyGetQuizz();
			initListeners();
		}
		public function valideReponse(numQuestion:uint,numReponse:uint):void 
		{
			loaderQuizz.signalReponse.add(reponsePrete);
			loaderQuizz.valideReponse(numQuestion,numReponse);
		}
		public function actualiseQuestions(questions:Vector.<QuestionShortVO>):void {
			MonsterDebugger.trace(this,"mise à jour : " + questions);
			listeQuestionsChoisies = new Array();
			var newQuestion:*;
			for each (var question:QuestionShortVO in questions) 
			{
				newQuestion = gestionQuestions.getQuestion(question.numQuestion);
				newQuestion.dejaFait = question.dejaFait;
				listeQuestionsChoisies.push(newQuestion);
				trace(newQuestion);
				switch (newQuestion.type) {
					case "video_choixPhoto" :
						trace((newQuestion as QuestionVideoChoixPhotoVO).urlExtrait);
						break;
					default :
						break;
				}
			}

		}
		private function reponsePrete(reponse:String,xmlResult:XML):void {		
			MonsterDebugger.trace(this,"reponse prete dans quizzcontrol : " +reponse);
			signalReponse.dispatch(xmlResult);
		}
		private function initListeners():void {
			gestionQuestions.signalReady.add(questionsReady);
			gestionQuestions.getQuestions();
		}
		private function questionsReady(all:Array):void {
			if (all) {
				allQuestions = all;
				trace("questions prêtes");
				initLoadings();
			}
		}
		private function initLoadings():void {
			loaderInitVars.signalInitVars.add(majInitVars);
			loaderQuizz.signalQuestions.add(majListeQuestions);
			loaderInitVars.loadInitVars();
			loaderQuizz.getListeQuestions();			
		}
		
		private function majListeQuestions(reponseVector:Vector.<QuestionShortVO>):void
		{
			//trace(reponseVector.toString());
			listeQuestionsChoisies = new Array();
			var newQuestion:*;
			for each (var question:QuestionShortVO in reponseVector) 
			{
				newQuestion = gestionQuestions.getQuestion(question.numQuestion);
				newQuestion.dejaFait = question.dejaFait;
				listeQuestionsChoisies.push(newQuestion);
				trace(newQuestion);
				switch (newQuestion.type) {
					case "video_choixPhoto" :
						trace((newQuestion as QuestionVideoChoixPhotoVO).urlExtrait);
						break;
					default :
						break;
				}
			}
			signalReady.dispatch(true);
		}
		private function majInitVars(_score:uint,_step:uint):void 
		{
			score = _score;
			step = _step;			
		}
		
	}
}