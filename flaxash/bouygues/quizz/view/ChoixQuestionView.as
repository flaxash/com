package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	import org.osflash.signals.Signal;
	
	public class ChoixQuestionView extends MovieClip
	{
		private var listeQuestions:Vector.<QuestionVO>;
		public var signalChoix:Signal;
		public function ChoixQuestionView()
		{
			super();
			init();
		}
		public function setQuestions(q1:QuestionVO,q2:QuestionVO,q3:QuestionVO,q4:QuestionVO,q5:QuestionVO):void 
		{		
			listeQuestions = new Vector.<QuestionVO>();
			listeQuestions.push(q1,q2,q3,q4,q5);
			initListeners();
			trace(q1.dejaFait + "-"+q2.dejaFait + "-" + q3.dejaFait + "-" + q4.dejaFait + "-" + q5.dejaFait);
		}
		private function init():void {
			signalChoix = new Signal(uint);
			
		}
		private function initListeners():void {
			var nomBouton:String = "";
			var bouton:SimpleButton;
			for (var i:uint=1;i<6;i++) {
				nomBouton = "bouton" + i;
				bouton = this.getChildByName(nomBouton);			
				bouton.enabled != listeQuestions[i].dejaFait;
				validate(bouton);
			}
			
		}
		private function validate(monBouton:SimpleButton):void {
			//grise le clip et enleve le listener si dejaFait=true
			if (!monBouton.enabled) {
				
			}
		}
	}
}