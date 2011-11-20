package com.flaxash.bouygues.quizz.model.proxy
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionShortVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.osflash.signals.Signal;

	public class ProxyGetQuizz
	{
		private static const URL_PHP_QUIZZ:String = "http://samesame.php-web.fr/lmfao/services/quizz.php";
		
		public var signalReponse:Signal;
		public var signalQuestions:Signal;
		
		private var loaderReponse:URLLoader;
		private var loaderQuestions:URLLoader;
		private var maRequete:URLRequest;
		private var reponseXML:XML;
		
		public function ProxyGetQuizz()
		{
			//constructeur
			signalReponse = new Signal();
			signalQuestions = new Signal();
			maRequete = new URLRequest(URL_PHP_QUIZZ);
			maRequete.method = URLRequestMethod.GET;
			loaderQuestions = new URLLoader();
			loaderQuestions.addEventListener(Event.COMPLETE,questionsCompleteHandler);
			loaderQuestions.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			loaderReponse = new URLLoader();
			loaderReponse.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loaderReponse.addEventListener(Event.COMPLETE, reponseCompleteHandler);
			
		}
		
		protected function reponseCompleteHandler(event:Event):void
		{
			try {
				reponseXML = new XML(loaderReponse.data);
				if (reponseXML.win ==1) {
					signalReponse.dispatch("vrai");
				} else { 
					signalReponse.dispatch("faux"); 
				}   
			} catch (e:TypeError) {
				trace("Could not parse the XML file.");
			}
		}
		protected function questionsCompleteHandler(event:Event):void 
		{
			try {
				reponseXML = new XML(loaderQuestions.data);
				var listeQuestions:Vector.<QuestionShortVO> = new Vector.<QuestionShortVO>();
				var objQuestionShort:QuestionShortVO;
				for each (var noeud:XML in reponseXML.q)
				{
					objQuestionShort = new QuestionShortVO();
					objQuestionShort.dejaFait = noeud.@rep==1?true:false;
					objQuestionShort.numQuestion = uint(noeud.toString());
					listeQuestions.push(objQuestionShort);
					
				}
				signalQuestions.dispatch(listeQuestions);
			} catch (e:TypeError) {
				trace("Could not parse the XML file.");
			}

			
		}
		protected function errorHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		public function valideReponse(numQuestion:uint,numReponse:uint):void {
			var dataReponse:Object = new Object();
			dataReponse.idQuestion = numQuestion;
			dataReponse.idReponse = numReponse;
			maRequete.data = dataReponse;
			loaderReponse.load(maRequete);
		}
		public function getListeQuestions():void {
			loaderQuestions.load(maRequete);
		}
	}
}