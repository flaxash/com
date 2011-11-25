package com.flaxash.bouygues.quizz.model.proxy
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionShortVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.osflash.signals.Signal;
	
	public class ProxyGetQuizz
	{
		private static const URL_PHP_QUIZZ:String = "http://samesame.php-web.fr/lmfao/services/quizz.php";
		
		public var signalReponse:Signal;
		public var signalQuestions:Signal;
		
		private var loaderReponse:URLLoader;
		private var loaderQuestions:URLLoader;
		private var maRequeteGet:URLRequest;
		private var maRequetePost:URLRequest;
		private var reponseXML:XML;
		
		public function ProxyGetQuizz()
		{
			//constructeur
			signalReponse = new Signal();
			signalQuestions = new Signal();
			maRequeteGet = new URLRequest(URL_PHP_QUIZZ);
			maRequetePost = new URLRequest(URL_PHP_QUIZZ);
			maRequeteGet.method = URLRequestMethod.GET;
			maRequetePost.method = URLRequestMethod.POST;
			loaderQuestions = new URLLoader();
			loaderQuestions.addEventListener(Event.COMPLETE,questionsCompleteHandler);
			loaderQuestions.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			loaderReponse = new URLLoader();
			loaderReponse.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loaderReponse.addEventListener(Event.COMPLETE, reponseCompleteHandler);
			
		}
		
		protected function reponseCompleteHandler(event:Event):void
		{
			MonsterDebugger.trace(this,"réponse reçue :-) : " + loaderReponse.data);
			try {
				reponseXML = new XML(loaderReponse.data);
				if (reponseXML.win ==1) {
					signalReponse.dispatch("vrai",reponseXML);
					//MonsterDebugger.trace(this,"vrai:" + reponseXML);
				} else { 
					signalReponse.dispatch("faux",reponseXML); 
					//MonsterDebugger.trace(this,"faux:" + reponseXML);
				}   
			} catch (e:TypeError) {
				trace("Could not parse the XML file. (from ProxyGetQuizz)");
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
					MonsterDebugger.trace(this,uint(noeud.@rep.toString()));
					objQuestionShort = new QuestionShortVO();
					objQuestionShort.dejaFait = Boolean(uint(noeud.@rep.toString()));
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
			MonsterDebugger.trace(this,"erreur pendant la requete php : " + event);
			
		}
		public function valideReponse(numQuestion:uint,numReponse:uint):void {
			MonsterDebugger.trace(this,"validation de réponse demandée...");
			var dataReponse:URLVariables = new URLVariables();
			dataReponse.idquest = numQuestion;
			dataReponse.idreponse = numReponse;
			maRequetePost.data = dataReponse;
			loaderReponse.load(maRequetePost);
		}
		public function getListeQuestions():void {
			loaderQuestions.load(maRequeteGet);
		}
	}
}