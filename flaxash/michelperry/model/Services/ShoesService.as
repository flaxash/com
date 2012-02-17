package com.flaxash.michelperry.model.Services
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	
	import org.osflash.signals.Signal;
	
	public class ShoesService
	{
		public var signalLoading:Signal;
		private var monLoader:LoaderMax;

		private static const URLXMLSHOEAH11:String = "assets/AH11/shoes.xml";
		private static const URLXMLSHOEPE12:String = "assets/PE12/shoes.xml";
		
		public function ShoesService()
		{
	  		signalLoading = new Signal();
	 		//startLoading();
		}
		public function startLoading():void {
			monLoader = new LoaderMax({onComplete:xmlLoaded,onError:pbLoading});
			monLoader.append(new XMLLoader(URLXMLSHOEAH11,{name:"AH11"}));
			monLoader.append(new XMLLoader(URLXMLSHOEPE12,{name:"PE12"}));
			monLoader.load(true);
			trace("loading appelé");
		}
		private function xmlLoaded(le:LoaderEvent):void {
			trace("shoesService : " + monLoader.bytesLoaded);
			signalLoading.dispatch(monLoader.getContent("AH11") as XML,monLoader.getContent("PE12") as XML);
		}
		private function pbLoading(le:LoaderEvent):void {
			trace(le.data);
		}
	}
}