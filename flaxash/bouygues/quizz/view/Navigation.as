package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVideoChoixPhotoVO;
	import com.flaxash.bouygues.quizz.view.QuestionSonView;
	import com.flaxash.bouygues.quizz.view.QuestionVideoView;
	import com.flaxash.bouygues.quizz.view.QuestionVisuelView;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	
	public class Navigation
	{
		public var signalTransition:Signal = new Signal();
		//states
		public var currentState:String;
		public var ecranActif:MovieClip;
		public var ecrans:Array;
		private var statesArray:Array = new Array("pageGo","choixQuestion","question","amis","loading");
		private var pageGo:PageGoView;
		private var choixQuestion:ChoixQuestionView;
		private var questionSon:QuestionSonView;
		private var questionVideo:QuestionVideoView;
		private var questionVideoChoixPhoto:QuestionVideoChoixPhotoView;
		private var questionVisuel:QuestionVisuelView;
		private var questionVisuel2Reponses:QuestionVisuel2ReponsesView;
		private var loadingView:LoadingView;
		private var viralisationView:ViralisationView;
		
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
									  _viralisationView:ViralisationView):void 
		{
			pageGo = _pageGo;
			choixQuestion = _choixQuestion;
			questionSon = _questionSon;
			questionVideo = _questionVideo;
			questionVideoChoixPhoto = _questionVideoChoixPhoto;
			questionVisuel = _questionVisuel;
			questionVisuel2Reponses = _questionVisuel2Reponses;
			loadingView = _loadingView;
			viralisationView = _viralisationView;
			
			ecrans = new Array(pageGo,choixQuestion,questionSon,questionVideo,questionVideoChoixPhoto,questionVisuel,questionVisuel2Reponses,loadingView,viralisationView);
			
			
		}
		public function allInvisible():void {
			for each (var monMC:MovieClip in ecrans) {
				if (monMC) {
				trace(monMC);
				monMC.visible=false;
				}
			}
		}

		public function affiche(monMC:MovieClip):void {
			allInvisible();
			monMC.visible = true;
		}
		
		private function transitionFinie(e:Event):void 
		{
			signalTransition.dispatch("fin");	
		}
	}
}