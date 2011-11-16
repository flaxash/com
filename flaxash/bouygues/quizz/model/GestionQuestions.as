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
		private var _allQuestions:Vector.<QuestionVO>;
		private var _questions:Vector.<QuestionVO>;
		
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

		private function questionsLoaded(questions:Vector.<QuestionVO>):void {
			_allQuestions = questions;
			tirageAleat(_allQuestions,3);
		}
		private function tirageAleat(questions:Vector.<QuestionVO>,nb:uint):void {
			var vectorTemp:Vector.<QuestionVO> = questions;
			_questions = new Vector.<QuestionVO>();
			for (var i:uint=0;i<nb;i++) {
				var n:uint = Math.floor(Math.random()*vectorTemp.length);
				_questions.push(vectorTemp[n]);
			}
			trace(_questions);
			signalReady.dispatch(true);
		}
	}
}