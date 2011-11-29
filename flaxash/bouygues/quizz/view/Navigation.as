package com.flaxash.bouygues.quizz.view
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVideoChoixPhotoVO;
	import com.flaxash.bouygues.quizz.view.*;
	import com.flaxash.bouygues.quizz.view.QuestionSonView;
	import com.flaxash.bouygues.quizz.view.QuestionVideoView;
	import com.flaxash.bouygues.quizz.view.QuestionVisuelView;
	import com.flaxash.transitionParticules.GestionParticles;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;

	public class Navigation
	{
		public var signalTransition:Signal = new Signal();
		//states
		public var currentState:String;
		public var ecranActif:MovieClip;
		public var ecrans:Array;
		public var lastClip:MovieClip;

		private var positionsInit:Vector.<Number>;
		private var statesArray:Array = new Array("pageGo","choixQuestion","question","amis","loading");
		private var pageGo:PageGoView;
		private var choixQuestion:ChoixQuestionView;
		private var questionSon:QuestionSonView;
		private var questionVideo:QuestionVideoView;
		private var questionVideoChoixPhoto:QuestionVideoChoixPhotoView;
		private var questionVisuel:QuestionVisuelView;
		private var questionVisuel2Reponses:QuestionVisuel2ReponsesView;
		private var loading:LoadingView;
		private var tirageAuSort2:TirageAuSort2View;
		private var pageIntermediaire : PageIntermediaireView;
		private var page5Questions:Page5QuestionsView;
		
		public function Navigation()
		{
			//constructeur
			
		}
		public function makeTransition(lastClip:MovieClip, newClip:MovieClip):void
		{
			//effectue une transition entre 2 movieClips
			var maTransition:TimelineLite = new TimelineLite({onComplete:transitionFinie});
			maTransition.append(new TweenLite(lastClip,1,{alpha:0}));
			maTransition.append(new TweenLite(newClip,1,{alpha:1}));
			maTransition.play();
		}
		public function rotationBandeau():void 
		{
			//change le visuel du bandeau
		}
		public function injecteEcrans(_pageGo:PageGoView,
									  _choixQuestion:ChoixQuestionView,
									  _questionSon:QuestionSonView,
									  _questionVideo:QuestionVideoView,
									  _questionVideoChoixPhoto:QuestionVideoChoixPhotoView,
									  _questionVisuel:QuestionVisuelView,
									  _questionVisuel2Reponses:QuestionVisuel2ReponsesView,
									  _loadingView:LoadingView,
									  _tirageAS2:TirageAuSort2View,
									  _pageIntermediaire:PageIntermediaireView,
									  _page5Questions:Page5QuestionsView):void 
		{
			pageGo = _pageGo;
			choixQuestion = _choixQuestion;
			questionSon = _questionSon;
			questionVideo = _questionVideo;
			questionVideoChoixPhoto = _questionVideoChoixPhoto;
			questionVisuel = _questionVisuel;
			questionVisuel2Reponses = _questionVisuel2Reponses;
			loading = _loadingView;
			tirageAuSort2 = _tirageAS2;
			pageIntermediaire =_pageIntermediaire;
			page5Questions = _page5Questions;
			ecrans = new Array(pageGo,choixQuestion,questionSon,questionVideo,questionVideoChoixPhoto,questionVisuel,questionVisuel2Reponses,loading,tirageAuSort2,pageIntermediaire,page5Questions);
			positionsInit = new Vector.<Number>();
			for (var i :uint=0;i<ecrans.length;i++) {
				positionsInit.push(MovieClip(ecrans[i]).y);
			}
			
		}
		public function allInvisible():void {
			for each (var monMC:MovieClip in ecrans) {
				if (monMC) {
					trace(monMC);
					monMC.visible=false;
					monMC.enabled = false;
					monMC.y = 1000;
				}
			}
		}
		public function affiche(monMC:MovieClip,root:Sprite):void {
			MonsterDebugger.trace(this,monMC + " demandé");
			//allInvisible();
			makeLastInvisible();
			monMC.visible = true;
			monMC.enabled =true;
			animateComeIn(monMC);
			monMC.y = positionsInit[ecrans.indexOf(monMC)];
			lastClip=monMC;	
		}
		private function makeLastInvisible():void {
			if (lastClip) {
				lastClip.visible=false;
				//transitionOut(lastClip)
			} else { 
				allInvisible();
			}
		}
		private function transitionFinie(e:Event):void 
		{
			signalTransition.dispatch("fin");	
		}
		private function animateComeIn(mc:MovieClip):void {
			var monDO:DisplayObject;
			for (var i:uint=0;i<mc.numChildren;i++) 
			{
				monDO = DisplayObject(mc.getChildAt(i));
				monDO.cacheAsBitmap = true;
				TweenLite.from(monDO,0.8,{x:String(Math.pow(-1,i)*100),alpha:0,delay:i*0.2,ease:Quad.easeOut});
			}
		}
	}
}