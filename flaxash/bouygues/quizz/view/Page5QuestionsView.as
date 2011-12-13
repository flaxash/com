package com.flaxash.bouygues.quizz.view
{
	//import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.view.component.BandeauBas;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	
	public class Page5QuestionsView extends MovieClip
	{
		//sur la scène
		public var bandeauBas:BandeauBas;
		public var cibleVideo:MovieClip;
		//public var controlesVideo : MovieClip;
		private var monPlayer:Object;
		private var playerReady:Boolean=false;
		private var my_loader:Loader;
		//public var goUniversalBtn:SimpleButton;
		public var goUniversalMC:MovieClip;
		//à mettre à jour
		private static const ID_VIDEO_UNIVERSAL:String = "QYl0FTaIqF0";
		
		public function Page5QuestionsView()
		{
			super();
			visible=false;
			//à enlever avant mise en prod !!
			//initPage();
		}
		public function initPage():void {
			goUniversalMC.addEventListener(MouseEvent.CLICK,goUniversal);
			goUniversalMC.buttonMode=true;
			initYoutube();
		}
		
		//private functions
		
		private function goUniversal(me:MouseEvent):void {
			navigateToURL(new URLRequest("http://www.universalmobile.fr"),"_blank");
		}
		private function initYoutube():void {
			Security.allowDomain("www.youtube.com");
			Security.allowDomain("s.ytimg.com/yt/swfbin/");
			
			my_loader = new Loader();
			//my_loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
			var stringRequest:String = "http://www.youtube.com/v/"+ID_VIDEO_UNIVERSAL+"?version=3&color=white&modestbranding=1&rel=0&showinfo=0";
			//var stringRequest:String = "http://www.youtube.com/v/"+ID_VIDEO_UNIVERSAL+"?version=3";
			my_loader.load(new URLRequest(stringRequest));
			my_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
		}
		private function onLoaderInit(e:Event):void{
			cibleVideo.addChild(my_loader);
			monPlayer = my_loader.content;
			monPlayer.addEventListener("onReady", onPlayerReady); 
		} 
		private function onPlayerReady(e:Event):void{
			//MonsterDebugger.trace(this,"player youtube is ready !");
			monPlayer.setSize(240,135);
			my_loader.x = -240/2;
			my_loader.y = -135/2;
			playerReady =true;
			my_loader.visible = true;
			//joueVideo(ID_VIDEO_UNIVERSAL);
		}
/*		private function joueVideo(idVid:String):void {
			monPlayer.cueVideoById(idVid,0);
			monPlayer.seekTo(0.1,false);
			monPlayer.pauseVideo();
			controlesVideo.gotoAndStop("play");
			controlesVideo.addEventListener(MouseEvent.CLICK,playVideo);
		}
		private function playVideo(me:MouseEvent):void {
			controlesVideo.gotoAndStop("vide");
			controlesVideo.removeEventListener(MouseEvent.CLICK,playVideo);
			monPlayer.playVideo();
			monPlayer.addEventListener("onStateChange",detecteFin);
		}
		private function detecteFin(event:Event):void {
			if (Object(event).data==0) {
				controlesVideo.gotoAndStop("replay");			
				controlesVideo.addEventListener(MouseEvent.CLICK,replayVideo);
			}
		}
		private function replayVideo(me:MouseEvent):void {
			monPlayer.seekTo(0.1,false);
			monPlayer.playVideo();
			controlesVideo.gotoAndStop("vide");
		}
*/		
	}
}