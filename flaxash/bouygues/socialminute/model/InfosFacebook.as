package com.flaxash.bouygues.socialminute.model
{
	import com.flaxash.bouygues.socialminute.model.proxy.ProxyFacebook;
	
	import org.osflash.signals.Signal;

	//classe qui contient les infos Facebook
	public class InfosFacebook
	{
		public var signalInfosReady:Signal;
		private var facebookLoader:ProxyFacebook;
		
		public function InfosFacebook()
		{
			facebookLoader = new ProxyFacebook();
			signalInfosReady = new Signal();
		}
	}
}