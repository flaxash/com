package com.flaxash.bouygues.quizz.view
{
	//import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.view.component.BandeauBas;
	import com.flaxash.bouygues.quizz.view.component.BoutonReponse;
	import com.flaxash.bouygues.quizz.view.component.TimerQuestion;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.osflash.signals.Signal;
	
	public class QuestionView extends MovieClip
	{
		//sur la scene
		public var questionTF:TextField;
		public var timerQuestion:TimerQuestion;
		public var reponseBtn1:BoutonReponse;
		public var bouton1:SimpleButton;
		public var reponseBtn2:BoutonReponse;
		public var bouton2:SimpleButton;
		public var bandeauBas:BandeauBas;
		//optionnel
		public var reponseBtn3:BoutonReponse;
		public var bouton3:SimpleButton;
		
		private var monArray:Array ;
		private var _question:QuestionVO;
		
		public var signalReponse:Signal;
		
		public function QuestionView()
		{
			super();
			signalReponse = new Signal();
			visible = false;
		}
		
		public function get question():QuestionVO
		{
			return _question;
		}
		
		public function majView(value:QuestionVO):void {
			
			_question = value;
			questionTF.text = value.question.toUpperCase();
			questionTF.autoSize = TextFieldAutoSize.LEFT; 
			questionTF.y = timerQuestion.y - questionTF.textHeight * 0.5;
			reponseBtn1.setTexte(value.reponses[0]);
			reponseBtn1.majFormat(value.numQuestion);
			reponseBtn2.setTexte(value.reponses[1]);
			reponseBtn2.majFormat(value.numQuestion);
			if (value.nbReponses==3) {
				reponseBtn3.setTexte(value.reponses[2]);
				reponseBtn3.majFormat(value.numQuestion);
			}
			initListeners();
			
		}
		private function initListeners():void {
			//MonsterDebugger.trace(this,_question.nbReponses  + " réponses" );
			reponseBtn1.addEventListener(MouseEvent.CLICK,onClick);
			reponseBtn2.addEventListener(MouseEvent.CLICK,onClick);
			if (_question.nbReponses ==3) reponseBtn3.addEventListener(MouseEvent.CLICK,onClick);
			timerQuestion.signalTimer.add(tempsEcoule);
			timerQuestion.start();
		}
		protected function onClick(me:MouseEvent):void {
			//Transmet la réponse
			var num:uint = uint((me.currentTarget as BoutonReponse).name.charAt((me.currentTarget as BoutonReponse).name.length-1));
			//MonsterDebugger.trace(this,"choix de réponse : " +(me.currentTarget as BoutonReponse).name) + "ie " +num;
			signalReponse.dispatch(_question.numQuestion,num);
			timerQuestion.stopTimer();
			SoundMixer.stopAll();
		}
		protected function tempsEcoule():void {
			signalReponse.dispatch(_question.numQuestion,0);
			SoundMixer.stopAll();
			timerQuestion.stopTimer();
		}
		
	}
}