package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	
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
		public var reponse1:MovieClip;
		public var bouton1:SimpleButton;
		public var reponse2:MovieClip;
		public var bouton2:SimpleButton;
		//optionnel
		public var reponse3:MovieClip;
		public var bouton3:SimpleButton;
		
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

		public function set question(value:QuestionVO):void
		{
			_question = value;
			majView();
			initListeners();
		}
		private function majView():void {
			questionTF.text = _question.question;
			for (var i:uint=0;i<_question.nbReponses;i++) {
				var nomReponse:String = "reponse"+ i;
				(this.getChildByName(nomReponse) as TextField).text = question.reponses[i];
				
			}
		}
		private function initListeners():void {
			for (var i:uint=0;i<_question.nbReponses;i++) {
				var nomBouton:String = "bouton"+ i;
				(this.getChildByName(nomBouton) as SimpleButton).addEventListener(MouseEvent.CLICK,onClick);
				
			}

		}
		private function onClick(me:MouseEvent):void {
			//Transmet la réponse
			var num:uint = uint((me.target as SimpleButton).name.charAt((me.target as SimpleButton).name.length-1));
			signalChoix.dispatch(num);
		}

	}
}