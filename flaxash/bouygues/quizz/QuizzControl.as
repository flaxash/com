package com.flaxash.bouygues.quizz
{
	//import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.*;
	import com.flaxash.bouygues.quizz.model.VO.*;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyGetInitVars;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyGetQuizz;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyLoaderQuestions;
	
	import flash.display.Sprite;
	
	import org.osflash.signals.Signal;
	
	public class QuizzControl extends Sprite
	{
		private var gestionQuestions:GestionQuestions;
		private var gestionScore:GestionScore;
		private var loaderInitVars:ProxyGetInitVars;
		private var loaderQuizz:ProxyGetQuizz;
		private var loadingsTraites:uint;
		private var sessid:String="";
		public var listeQuestionsChoisies:Array;
		public var allQuestions:Array;
		public var nbQuestionsRestantes:uint;
		
		public var signalReady:Signal;
		public var signalReponse:Signal;
		public var step:uint;
		public var score:uint;
		
		
		public function QuizzControl(_sessid:String="")
		{
			super();
			sessid=_sessid;
			signalReady = new Signal(Boolean);
			signalReponse = new Signal(XML);

		}
		public function init():void {
			gestionQuestions = new GestionQuestions();
			gestionScore = new GestionScore();
			loaderInitVars = new ProxyGetInitVars(sessid);
			loaderQuizz = new ProxyGetQuizz(sessid);
			loadingsTraites=0;
			initListeners();
		}
		public function valideReponse(numQuestion:uint,numReponse:uint):void 
		{
			loaderQuizz.signalReponse.add(reponsePrete);
			loaderQuizz.valideReponse(numQuestion,numReponse);
		}
		public function actualiseQuestions(questions:Vector.<QuestionShortVO>):void {
			//MonsterDebugger.trace(this,"mise à jour : " + questions);
			listeQuestionsChoisies = new Array();
			var newQuestion:*;
			nbQuestionsRestantes = 5;
			for each (var question:QuestionShortVO in questions) 
			{
				newQuestion = gestionQuestions.getQuestion(question.numQuestion);
				newQuestion.dejaFait = question.dejaFait;
				if (newQuestion.dejaFait) nbQuestionsRestantes--;
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
		public function getQuestions():Vector.<QuestionShortVO> 
		{
			var newQuestions:Vector.<QuestionShortVO> = new Vector.<QuestionShortVO>();
			for each (var questionVO:QuestionVO in listeQuestionsChoisies) 
			{
				var maQuestionShort:QuestionShortVO = new QuestionShortVO();
				maQuestionShort.dejaFait = questionVO.dejaFait;
				maQuestionShort.numQuestion = questionVO.numQuestion;
				newQuestions.push(maQuestionShort);
			}
			return newQuestions;
		}
		private function reponsePrete(reponse:String,xmlResult:XML):void {		
			//MonsterDebugger.trace(this,"reponse prete dans quizzcontrol : " +reponse);
			signalReponse.dispatch(xmlResult);
		}
		private function initListeners():void {
			gestionQuestions.signalReady.add(questionsReady);
			gestionQuestions.getQuestions();
		}
		private function questionsReady(all:Array):void {
			if (all) {
				allQuestions = all;
				//MonsterDebugger.trace(this,"questions prêtes");
				initLoadings();
			}
		}
		private function initLoadings():void {
			loaderInitVars.signalInitVars.add(majInitVars);
			loaderQuizz.signalQuestions.add(majListeQuestions);
			loaderInitVars.loadInitVars();
			//loaderQuizz.getListeQuestions();
						
		}
		
		private function majListeQuestions(reponseVector:Vector.<QuestionShortVO>):void
		{
			loadingsTraites++;
			//trace(reponseVector.toString());
			listeQuestionsChoisies = new Array();
			var newQuestion:*;
			nbQuestionsRestantes = 5;
			for each (var question:QuestionShortVO in reponseVector) 
			{
				newQuestion = gestionQuestions.getQuestion(question.numQuestion);
				newQuestion.dejaFait = question.dejaFait;
				if (newQuestion.dejaFait) nbQuestionsRestantes--;
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
			//MonsterDebugger.trace(this,"listeQuestions prêtes " + "- "+loadingsTraites);
			if (loadingsTraites==2) signalReady.dispatch(true);
		}
		private function majInitVars(_score:uint,_step:uint):void 
		{
			loadingsTraites++;
			//MonsterDebugger.trace(this,"score.php reçu");
			score = _score;
			step = _step;	
			if (step==1 || step==3 || loadingsTraites==2) signalReady.dispatch(true);
			if (step==2) loaderQuizz.getListeQuestions();
		}
		
	}
}