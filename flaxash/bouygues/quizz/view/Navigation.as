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
	import com.greensock.TimelineMax;
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
		private var newClip:MovieClip;

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
			//makeLastInvisible();
			newClip=monMC;
			if (lastClip) animateOut(lastClip);
			else {
				newClip.visible = true;
				newClip.enabled =true;
				animateComeIn();
				newClip.y = positionsInit[ecrans.indexOf(newClip)];
			}
			
			
			//lastClip=monMC;	
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
		private function animateComeIn():void {
			MonsterDebugger.trace(this,"animateIn");
			//bascule de la visibilté
			newClip.visible = true;
			newClip.enabled =true;
			newClip.y = positionsInit[ecrans.indexOf(newClip)];
			if (lastClip) 
			{
				lastClip.visible = false;
				lastClip.enabled =false;
				lastClip.y = 1000;
			}
			var matimeline:TimelineMax = new TimelineMax({onComplete:setLastClip});
			var monDO:DisplayObject;
			for (var i:uint=0;i<newClip.numChildren;i++) 
			{
				monDO = DisplayObject(newClip.getChildAt(i));
				monDO.cacheAsBitmap = true;
				monDO.alpha=0;
				var xinit:Number = monDO.x;
				monDO.x = Math.pow(-1,i)*100;
				matimeline.insert( new TweenLite(monDO,0.8,{x:xinit,alpha:1,ease:Quad.easeOut}),0.1*i);
			}
			matimeline.play();
		}
		private function setLastClip ():void {
			//lastClip devient newClip
			lastClip=newClip;
			var monDO:DisplayObject;
			for (var i:uint=0;i<lastClip.numChildren;i++) 
			{
				monDO = DisplayObject(lastClip.getChildAt(i));
				monDO.alpha=1;
			}

		}
		private function animateOut(mc:MovieClip):void {
			var matimeline:TimelineMax = new TimelineMax({onComplete:animateComeIn});
			var monDO:DisplayObject;
			for (var i:uint=0;i<mc.numChildren;i++) 
			{
				monDO = DisplayObject(mc.getChildAt(i));
				monDO.cacheAsBitmap = true;
				matimeline.insert(new TweenLite(monDO,0.8,{alpha:0,ease:Quad.easeOut}),0.1*i);
			}
			matimeline.play();
		}
	}
}