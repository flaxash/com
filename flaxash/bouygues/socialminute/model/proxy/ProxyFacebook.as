package com.flaxash.bouygues.socialminute.model.proxy
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	
	import org.osflash.signals.Signal;

	//classe pour charger les infos Facebook depuis php
	public class ProxyFacebook
	{
		
		public var signalChargementFini:Signal;
		private var XMLFacebook:XMLLoader;
		//statique
		//public static const URL_XML:String = "fbservices/infosFacebook_bug.xml";
		//dynamique
		public static const URL_XML:String = "fbservices/infosFacebook.php?sess=";
		
		public function ProxyFacebook()
		{
			signalChargementFini = new Signal(XML);
			
		}
		
		public function getResult(sess:String=""):void {
			//statique
			//XMLFacebook = new XMLLoader(URL_XML,{onComplete:chargementFini});
			//dynamique avec session
			XMLFacebook = new XMLLoader(URL_XML+sess,{onComplete:chargementFini,onError:pbChargement});
			//chargement des données
			XMLFacebook.load(true);
		}
		private function  chargementFini(le:LoaderEvent):void {
			//trace(XML(le.target.content));
			trace("chargement du xml ok");
			MonsterDebugger.trace(this,XML(le.target.content));
			signalChargementFini.dispatch(XML(le.target.content));
		}
		private function pbChargement(le:LoaderEvent):void {
			MonsterDebugger.trace(this,le.toString());
		}
	}
}