package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVideoVO;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	public class QuestionVideoView extends QuestionView
	{
		//sur la scène
		public var cibleVideo:MovieClip;
		
		private var monPlayer:Object;
		private var playerReady:Boolean=false;
		private var idVideo:String;
		private var my_loader:Loader;
		public function QuestionVideoView()
		{
			//initYoutube();
		}
		
		override public function majView(value:QuestionVO):void 
		{
			super.majView(value);
			var question:QuestionVideoVO = value as QuestionVideoVO;
			
			
			idVideo = question.urlExtrait;
			if (playerReady) joueVideo(idVideo);
			
		}
		private function initYoutube():void {
			Security.allowDomain("www.youtube.com");
			
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
			monPlayer.setSize(480,270);
			playerReady =true;
			if (idVideo) {
				joueVideo(idVideo);
			}
		}
		private function joueVideo(idVid:String):void {
			monPlayer.cueVideoById(idVid,0);
			monPlayer.playVideo();
		}
		
	}
}