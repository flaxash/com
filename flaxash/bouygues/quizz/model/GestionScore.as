package com.flaxash.bouygues.quizz.model
{
	import com.flaxash.bouygues.quizz.model.proxy.ProxyMajScore;

	public class GestionScore
	{
		//classe qui gère le score de l'internaute et demande la mise à jour sur une bdd
		
		private var _score:uint = 0;
		private var proxyScore:ProxyMajScore;
		
		public function GestionScore()
		{
			proxyScore = new ProxyMajScore();
		}
		
		public function majScoreServeur():void {
			proxyScore.saveScore(_score);
		}

		public function get score():uint
		{
			return _score;
		}

		public function set score(value:uint):void
		{
			_score = value;
			majScoreServeur();
		}
		public function bonneReponse():void {
			score +=50;
		}

	}
}