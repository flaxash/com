package com.flaxash.bouygues.socialminute.model
{
	import com.flaxash.bouygues.socialminute.model.proxy.ProxyFacebook;
	
	import org.osflash.signals.Signal;

	//classe qui contient les infos Facebook
	public class InfosFacebook
	{
		public var signalInfosReady:Signal;
		private var facebookLoader:ProxyFacebook;
		private var _xmlInfos:XML;
		
		public function InfosFacebook()
		{
			
			signalInfosReady = new Signal();
			facebookLoader = new ProxyFacebook();
			facebookLoader.signalChargementFini.add(transmetInfos);
		}
		public function loadXML(sess:String):void {
			facebookLoader.getResult(sess);
		}
		private function transmetInfos(monXML:XML):void {
			
			//trace("depuis InfosFacebook : " + monXML);
			_xmlInfos = monXML;
			signalInfosReady.dispatch();
		}

		public function get xmlInfos():XML
		{
			return _xmlInfos;
		}

		public function set xmlInfos(value:XML):void
		{
			_xmlInfos = value;
		}

	}
}