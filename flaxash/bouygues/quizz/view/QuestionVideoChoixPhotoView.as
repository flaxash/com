package com.flaxash.bouygues.quizz.view
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVideoChoixPhotoVO;
	import com.flaxash.bouygues.quizz.view.component.BoutonVisuelReponse;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	
	import org.osflash.signals.Signal;
	
	public class QuestionVideoChoixPhotoView extends MovieClip
	{
		//sur la scène
		public var cibleVideo:MovieClip;
		public var controlesVideo:MovieClip;
		public var questionTF:TextField;
		public var timerQuestion:MovieClip;
		public var reponseBtn1:BoutonVisuelReponse;
		public var reponseBtn2:BoutonVisuelReponse;
		public var reponseBtn3:BoutonVisuelReponse;
		
		private var monArray:Array = new Array(reponseBtn1,reponseBtn2,reponseBtn3);
		private var _question:QuestionVideoChoixPhotoVO;
		
		public var signalReponse:Signal;

		private var monPlayer:Object;
		private var playerReady:Boolean=false;
		private var idVideo:String;
		private var my_loader:Loader;
		
		public function QuestionVideoChoixPhotoView()
		{
			super();
			visible=false;
			initYoutube();
		}
		public function majView(question:QuestionVideoChoixPhotoVO):void 
		{
			_question = question;
			signalReponse = new Signal();
			MonsterDebugger.trace(this,"majView dans QuestionVideoChoixPhoto : ");
			MonsterDebugger.trace(this,question);
			questionTF.text = question.question.toUpperCase();
			reponseBtn1.setVisuel(question.nomsPhotos[0]);
			reponseBtn2.setVisuel(question.nomsPhotos[1]);
			reponseBtn3.setVisuel(question.nomsPhotos[2]);
			//super.majView(value);
						
			idVideo = question.urlExtrait;
			if (playerReady) joueVideo(idVideo);
			
			initListeners()

			
		}
		private function initListeners():void {
			MonsterDebugger.trace(this,_question.numQuestion  + " a " + _question.nomsPhotos.length + " réponses" );
			reponseBtn1.addEventListener(MouseEvent.CLICK,onClick);
			reponseBtn2.addEventListener(MouseEvent.CLICK,onClick);
			reponseBtn3.addEventListener(MouseEvent.CLICK,onClick);
		}

		private function initYoutube():void {
			Security.allowDomain("www.youtube.com");
			Security.allowDomain("s.ytimg.com");
			
			my_loader = new Loader();
			my_loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3")); 
			my_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
		}
		private function onLoaderInit(e:Event):void{
			//my_loader.visible=false;
			
			cibleVideo.addChild(my_loader);
			
			
			monPlayer = my_loader.content;
			monPlayer.addEventListener("onReady", onPlayerReady); 
			
		} 
		private function onPlayerReady(e:Event):void{
			MonsterDebugger.trace(this,"player youtube is ready !");
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
			monPlayer.playVideo();
			monPlayer.pauseVideo();
			controlesVideo.gotoAndStop("play");
			controlesVideo.addEventListener(MouseEvent.CLICK,playVideo);
		}
		private function onClick(me:MouseEvent):void {
			//Transmet la réponse
			var num:uint = uint((me.currentTarget as BoutonVisuelReponse).name.charAt((me.currentTarget as BoutonVisuelReponse).name.length-1));
			MonsterDebugger.trace(this,"choix de réponse : " +(me.currentTarget as BoutonVisuelReponse).name + " ie " +num);
			signalReponse.dispatch(_question.numQuestion,num);
		}
		private function playVideo(me:MouseEvent):void {
			controlesVideo.gotoAndStop("vide");
			monPlayer.playVideo();
			monPlayer.addEventListener("onStateChange",detecteFin);
		}
		private function detecteFin(event:Event):void {
			if (Object(event).data==0) {
				controlesVideo.gotoAndStop("replay");
				controlesVideo.removeEventListener(MouseEvent.CLICK,playVideo);
				controlesVideo.addEventListener(MouseEvent.CLICK,replayVideo);
			}
		}
		private function replayVideo(me:MouseEvent):void {
			monPlayer.seekTo(0,false);
			monPlayer.playVideo();
			controlesVideo.gotoAndStop("vide");
		}


	}
}