package com.flaxash.bouygues.socialminute.model.proxy
{
	import org.osflash.signals.Signal;

	//classe pour charger les infos Facebook depuis php
	public class ProxyFacebook
	{
		
		public var signalChargementFini:Signal;
		public static const URL_PHP:String = "";
		
		public function ProxyFacebook()
		{
			signalChargementFini = new Signal();
		}
		
		public function getResult():void {
			//chargement des données
		}
	}
}