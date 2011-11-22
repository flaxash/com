package com.flaxash.bouygues.quizz.view
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.view.component.BoutonReponse;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.osflash.signals.Signal;
	
	public class QuestionView extends MovieClip
	{
		//sur la scene
		public var questionTF:TextField;
		public var timerQuestion:MovieClip;
		public var reponseBtn1:MovieClip;
		public var bouton1:SimpleButton;
		public var reponseBtn2:MovieClip;
		public var bouton2:SimpleButton;
		//optionnel
		public var reponseBtn3:MovieClip;
		public var bouton3:SimpleButton;
		
		private var monArray:Array = new Array(reponseBtn1,reponseBtn2,reponseBtn3);
		private var _question:QuestionVO;
		
		public var signalChoix:Signal;
		
		public function QuestionView()
		{
			super();
			signalChoix = new Signal();
			visible = false;
		}
		
		public function get question():QuestionVO
		{
			return _question;
		}
		
		public function majView(value:QuestionVO):void {
			_question = value;
			questionTF.text = value.question.toUpperCase();
			MonsterDebugger.trace(this,value.nbReponses);
			
			//problème dans cette fonction ...
			/*for (var i:uint=1;i<value.nbReponses+1;i++) {
			var nomBouton:String = "reponseBtn"+ i;
			MonsterDebugger.trace(this,(this.getChildByName(nomBouton) as BoutonReponse));
			(this.getChildByName(nomBouton) as BoutonReponse).setTexte( value.reponses[i-1].toUpperCase());
			}*/
			var i:uint=0;
			for each (var monBouton:BoutonReponse in monArray) {
				monBouton.setTexte(value.reponses[i].toUpperCase());
				i++;
			}
			initListeners();
			
		}
		private function initListeners():void {
			MonsterDebugger.trace(this,_question.nbReponses);
			
			for (var i:uint=1;i<_question.nbReponses+1;i++) {
				var nomBouton:String = "reponseBtn"+ i;
				MonsterDebugger.trace(this,(this.getChildByName(nomBouton) as BoutonReponse));
				(this.getChildByName(nomBouton) as BoutonReponse).addEventListener(MouseEvent.CLICK,onClick);
				
			}
			
		}
		private function onClick(me:MouseEvent):void {
			//Transmet la réponse
			var num:uint = uint((me.target as SimpleButton).name.charAt((me.target as SimpleButton).name.length-1));
			signalChoix.dispatch(num);
		}
		
	}
}