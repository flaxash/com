package com.flaxash.bouygues.quizz.view
{
	//import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVideoVO;
	import com.flaxash.bouygues.quizz.view.component.BoutonReponse;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	public class QuestionVideoView extends QuestionView
	{
		//sur la scène
		public var cibleVideo:MovieClip;
		public var controlesVideo : MovieClip;
		private var monPlayer:Object;
		private var playerReady:Boolean=false;
		private var idVideo:String;
		private var my_loader:Loader;
		
		
		public function QuestionVideoView()
		{
			initYoutube();
		}
		//override functions
		override public function majView(value:QuestionVO):void 
		{
			super.majView(value);
			var question:QuestionVideoVO = value as QuestionVideoVO;
			
			
			idVideo = question.urlExtrait;
			if (playerReady) joueVideo(idVideo);
			
		}
		override protected function onClick(me:MouseEvent):void {
			super.onClick(me);
			monPlayer.pauseVideo();
		}
		override protected function tempsEcoule():void {
			super.tempsEcoule();
			monPlayer.pauseVideo();
		}
		//private functions
		private function initYoutube():void {
			Security.allowDomain("www.youtube.com");
			Security.allowDomain("s.ytimg.com/yt/swfbin/");
			
			my_loader = new Loader();
			my_loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3")); 
			my_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
		}
		private function onLoaderInit(e:Event):void{
			cibleVideo.addChild(my_loader);
			monPlayer = my_loader.content;
			monPlayer.addEventListener("onReady", onPlayerReady); 
		} 
		private function onPlayerReady(e:Event):void{
			//MonsterDebugger.trace(this,"player youtube is ready !");
			monPlayer.setSize(480,270);
			
			my_loader.x = -480/2;
			my_loader.y = -270/2;
			playerReady =true;
			if (idVideo) {
				my_loader.visible = true;
				joueVideo(idVideo);
			}
		}
		private function joueVideo(idVid:String):void {
			monPlayer.cueVideoById(idVid,0);
			monPlayer.seekTo(0.1,false);
			monPlayer.pauseVideo();
			monPlayer.setPlaybackQuality("medium");
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
	}
}