package com.flaxash.bouygues.quizz.model.proxy
{
	//communique avec php ou javascript pour mise à jour du score au Quizz
	public class ProxyMajScore
	{
		private static const URL_MAJ_SERVEUR:String = "majScore.php";
		
		public function ProxyMajScore()
		{
		}
		
		public function saveScore(newScore:uint):void {
			//appelle à la fonction qui sauve le score dans la bdd
		}
		
		public function getScore():uint {
			//appelle à la fonction qui récupère la score dans la bdd
		}
	}
}