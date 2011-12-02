package com.flaxash.bouygues.quizz.model.proxy
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.osflash.signals.Signal;

	//import com.demonsters.debugger.MonsterDebugger;
	public class ProxyGetInitVars
	{
		//private static const URL_PHP_SCORE:String = "http://samesame.php-web.fr/lmfao/services/score.php";
		private static const URL_PHP_SCORE:String = "services/score.php";
		private var loaderScore:URLLoader;
		private var maRequete:URLRequest;
		private var reponseXML:XML;
		
		public var signalInitVars:Signal;
		public function ProxyGetInitVars()
		{
			//constructeur
			signalInitVars = new Signal(uint,uint);
		}
		public function loadInitVars():void 
		{
			loaderScore= new URLLoader();
			maRequete = new URLRequest(URL_PHP_SCORE);
			maRequete.method = URLRequestMethod.GET;
			loaderScore.addEventListener(Event.COMPLETE,onLoadComplete);
			loaderScore.load(maRequete);
			
		}
		private function onLoadComplete(e:Event):void {
			try {
				reponseXML = new XML(loaderScore.data);
				var score:uint = uint(reponseXML.score.toString());
				var step:uint = uint(reponseXML.step.toString());
				signalInitVars.dispatch(score,step);
				//MonsterDebugger.trace(this,"vars step et score loaded : " + score + " - " + step);
			} catch (e:TypeError) {
				trace("Could not parse the score XML file.");
				//loaderScore.load(maRequete);
			}
			
		}
	}
}