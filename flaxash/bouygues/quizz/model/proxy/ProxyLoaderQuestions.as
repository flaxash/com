package com.flaxash.bouygues.quizz.model.proxy
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.*;
	
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
		private var questions:Array;
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
			questions = new Array();
			var question:*;
			for each (var noeudXML:XML in xmlLoaded..question) {
				//trace(noeudXML);
				//question = new QuestionVO();
				
				//trace(noeudXML.type.toString());
				switch(noeudXML.type.toString()) {
					case "son" :
						question = new QuestionSonVO();
						question.nomExtrait = noeudXML.nom_extrait;
						break;
					case "video" :
						question = new QuestionVideoVO();
						question.urlExtrait = noeudXML.url_extrait;
						break;
					case "video_choixPhoto" :
						question = new QuestionVideoChoixPhotoVO();
						question.urlExtrait = noeudXML.url_extrait;
						question.nomsPhotos = new Vector.<String>
						for each (var ref:XML in noeudXML.nom_photo) 
						{
							question.nomsPhotos.push(ref);
						}
						break;
					case "visuel" :
						question = new QuestionVisuelVO();
						question.nomVisuel = noeudXML.nom_visuel;
						break;
					case "visuel_2reponses":
						question = new QuestionVisuelVO();
						break;
					default :
						question = new QuestionVO();
						break;
				}
				question.numQuestion = noeudXML.@numQuestion;
				question.type = noeudXML.type;
				question.question = noeudXML.intitule;
				
				question.nbReponses = noeudXML.reponse.length();
				question.reponses = new Vector.<String>();
				for (var i:uint=0;i<question.nbReponses;i++) {
					
					question.reponses.push(noeudXML.reponse[i].toString())
				}
				//trace(question.question)
				questions.push(question);
				//MonsterDebugger.trace(this,question);
			}
			signalLoaded.dispatch(questions);
		}
	}
}