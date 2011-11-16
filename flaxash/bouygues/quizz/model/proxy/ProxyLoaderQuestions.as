package com.flaxash.bouygues.quizz.model.proxy
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	
	//classe pour charger les questions à partir du XML
	public class ProxyLoaderQuestions
	{
		public var signalLoaded:Signal = new Signal();
		
		private static const URL_XML_QUESTIONS:String = "questions.xml";
		private var loaderXML:URLLoader;
		private var questions:Vector.<QuestionVO>;
		public function ProxyLoaderQuestions()
		{
			//trace("ProxyLoaderQuestions");
		}
		public function loadQuestions():void 
		{
			loaderXML = new URLLoader();
			loaderXML.addEventListener(Event.COMPLETE,parseXMLToQuestions);
			loaderXML.load(new URLRequest(URL_XML_QUESTIONS));
		}
		private function parseXMLToQuestions(e:Event):void {
			var xmlLoaded:XML = XML(loaderXML.data);
			questions = new Vector.<QuestionVO>();
			var question:QuestionVO;
			for each (var noeudXML:XML in xmlLoaded..question) {
				trace(noeudXML);
				question = new QuestionVO();
				question.nbReponses = noeudXML.reponse.length;
				question.question = noeudXML.intitule;
				//correctif pour utiliser des entiers non nuls comme bonnes réponses
				question.reponseCorrecte = noeudXML.bonneReponse - 1;
				question.type = noeudXML.type;
				questions.push(question);
			}
			signalLoaded.dispatch(questions);
		}
	}
}