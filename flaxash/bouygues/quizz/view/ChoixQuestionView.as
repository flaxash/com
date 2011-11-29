package com.flaxash.bouygues.quizz.view
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionShortVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.view.component.BandeauBas;
	import com.flaxash.bouygues.quizz.view.component.BoutonChoixQuestion;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	import org.osflash.signals.Signal;
	
	public class ChoixQuestionView extends MovieClip
	{
		private var listeQuestions:Vector.<QuestionVO>;
		public var signalChoix:Signal;
		
		//sur la scène
		public var choixBtn1:BoutonChoixQuestion;
		public var choixBtn2:BoutonChoixQuestion;
		public var choixBtn3:BoutonChoixQuestion;
		public var choixBtn4:BoutonChoixQuestion;
		public var choixBtn5:BoutonChoixQuestion;
		public var bandeauBas:BandeauBas;
		
		private var greyMatrix:Array;
		private var myGreyMatrixFilter:ColorMatrixFilter;
		
		private static const NB_FRAMES_BOUTON:uint = 7;
		public function ChoixQuestionView()
		{
			super();
			init();
			visible = false;
			listeQuestions = new Vector.<QuestionVO>();
		}
		public function setQuestions(q1:QuestionVO,q2:QuestionVO,q3:QuestionVO,q4:QuestionVO,q5:QuestionVO):void 
		{		
			listeQuestions = new Vector.<QuestionVO>();
			listeQuestions.push(q1,q2,q3,q4,q5);
			initListeners();
			//trace(q1.dejaFait + "-"+q2.dejaFait + "-" + q3.dejaFait + "-" + q4.dejaFait + "-" + q5.dejaFait);
		}
		public function majChoix(mesChoix:Vector.<QuestionShortVO>):void {
			for (var i:uint=0;i<mesChoix.length;i++) {
				listeQuestions[i].dejaFait = mesChoix[i].dejaFait;
			}
			initListeners();
		}
		private function init():void {
			signalChoix = new Signal(uint);
			greyMatrix = new Array();
			//var r:Number=0.212671;
			//var g:Number=0.715160;
			//var b:Number=0.072169;
			var r:Number=0.33;
			var g:Number=0.33;
			var b:Number=0.34;
			greyMatrix = greyMatrix.concat([r,g,b, 0, 0]); // red
			greyMatrix = greyMatrix.concat([r,g,b, 0, 0]); // green
			greyMatrix = greyMatrix.concat([r,g,b, 0, 0]); // blue
			greyMatrix = greyMatrix.concat([0, 0, 0, 1, 0]); // alpha
			myGreyMatrixFilter = new ColorMatrixFilter(greyMatrix);
			
		}
		private function initListeners():void {
			var nomBouton:String = "";
			var bouton:MovieClip;
			var numFrame:uint=1;
			//MonsterDebugger.trace(this,listeQuestions[0].numQuestion%7 +1 + " frame de depart dans choixQuestion pour les boutons");
			var numDepart:uint = listeQuestions[0].numQuestion%NB_FRAMES_BOUTON + 1;
			//MonsterDebugger.trace(this,numDepart + " frame de depart dans choixQuestion pour les boutons");
			for (var i:uint=1;i<6;i++) {
				nomBouton = "choixBtn" + i;
				//MonsterDebugger.trace(this,"bouton : " +this.getChildByName(nomBouton));
				//MonsterDebugger.trace(this,listeQuestions);
				bouton = MovieClip(this.getChildByName(nomBouton));
				//if (listeQuestions[i-1]) 
				bouton.enabled = !listeQuestions[i-1].dejaFait;
				validate(bouton);
				numFrame = (numDepart + i)%NB_FRAMES_BOUTON + 1;
				MonsterDebugger.trace(this,numFrame + " a été choisie pour bouton " +i);
				bouton.visuels.gotoAndStop(numFrame);
				//bouton.buttonMode = true;
				//bouton.intro();
			}
			
		}
		private function validate(monBouton:MovieClip):void {
			MonsterDebugger.trace(this,monBouton.name +" enabled ? " + monBouton.enabled);
			//grise le clip et enleve le listener si dejaFait=true
			if (!monBouton.enabled) {
				monBouton.removeEventListener(MouseEvent.CLICK,choixBouton);
				monBouton.buttonMode = false;
				//grise le bouton
				monBouton.filters = [myGreyMatrixFilter];
			} else {
				monBouton.addEventListener(MouseEvent.CLICK,choixBouton);
				monBouton.buttonMode = true;
				//enleve les filtres
				monBouton.filters = null;
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