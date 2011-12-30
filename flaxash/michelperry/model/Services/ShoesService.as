package com.flaxash.michelperry.model.Services
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	
	import org.osflash.signals.Signal;
	
	public class ShoesService
	{
		public var signalLoading:Signal;
		
		private var xmlLoader:XMLLoader;
		private static const URLXMLSHOE:String = "assets/shoes.xml";
		
		public function ShoesService()
		{
	  		signalLoading = new Signal();
	 		//startLoading();
		}
		public function startLoading():void {
			xmlLoader = new XMLLoader(URLXMLSHOE,{onComplete:xmlLoaded,onError:pbLoading});
			xmlLoader.load();
			trace("loading appelé");
		}
		private function xmlLoaded(le:LoaderEvent):void {
			trace("shoesService : " + xmlLoader.content);
			signalLoading.dispatch(xmlLoader.content as XML);
		}
		private function pbLoading(le:LoaderEvent):void {
			trace(le.data);
		}
	}
}