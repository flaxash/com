package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class ChoixQuestionView extends MovieClip
	{
		private var listeQuestions:Vector.<QuestionVO>;
		public var signalChoix:Signal;
		
		//sur la scène
		public var choixBtn1:MovieClip;
		public var choixBtn2:MovieClip;
		public var choixBtn3:MovieClip;
		public var choixBtn4:MovieClip;
		public var choixBtn5:MovieClip;


		public function ChoixQuestionView()
		{
			super();
			init();
			visible = false;
		}
		public function setQuestions(q1:QuestionVO,q2:QuestionVO,q3:QuestionVO,q4:QuestionVO,q5:QuestionVO):void 
		{		
			listeQuestions = new Vector.<QuestionVO>();
			listeQuestions.push(q1,q2,q3,q4,q5);
			initListeners();
			//trace(q1.dejaFait + "-"+q2.dejaFait + "-" + q3.dejaFait + "-" + q4.dejaFait + "-" + q5.dejaFait);
		}
		private function init():void {
			signalChoix = new Signal(uint);
			
		}
		private function initListeners():void {
			var nomBouton:String = "";
			var bouton:MovieClip;
			for (var i:uint=1;i<6;i++) {
				nomBouton = "choixBtn" + i;
				trace("bouton : " +this.getChildByName(nomBouton));
				bouton = MovieClip(this.getChildByName(nomBouton));			
				//bouton.enabled != listeQuestions[i-1].dejaFait;
				validate(bouton);
			}
			
		}
		private function validate(monBouton:MovieClip):void {
			//grise le clip et enleve le listener si dejaFait=true
			if (!monBouton.enabled) {
				
			} else {
				monBouton.addEventListener(MouseEvent.CLICK,choixBouton);
			}
		}
		private function choixBouton(me:MouseEvent):void 
		{
			
			var nomClip:String = me.currentTarget.name;
			trace(me.currentTarget.name + "-" + uint(nomClip.substr(8,1)));
			var num:uint = uint(nomClip.substr(8,1));
			signalChoix.dispatch((listeQuestions[num-1] as QuestionVO).numQuestion);
			//signalChoix.dispatch(2);
		}
	}
}