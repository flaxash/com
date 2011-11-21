package com.flaxash.bouygues.quizz.model
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.proxy.ProxyLoaderQuestions;
	
	import org.osflash.signals.Signal;

	//classe pour gérer les questions du quizz
	public class GestionQuestions
	{
		
		public var signalReady:Signal;
		
		private var _proxyQuestions:ProxyLoaderQuestions;
		private var _allQuestions:Array;
		
		
		public function GestionQuestions()
		{
			initSignals();
		}
		public function getQuestions():void {
			_proxyQuestions = new ProxyLoaderQuestions();
			_proxyQuestions.signalLoaded.add(questionsLoaded);
			_proxyQuestions.loadQuestions();
		}
		private function initSignals():void {
			signalReady = new Signal();
		}

		private function questionsLoaded(questions:Array):void {
			_allQuestions = questions;
			signalReady.dispatch(_allQuestions);
			
		}
		public function getQuestion(id:uint):* {
			return _allQuestions[id-1];
		}
	}
}