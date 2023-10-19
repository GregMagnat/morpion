Morpiiiiiiiiiiiiiiiiiiiiiiiion !!!! 

4 classes qui correspondent à des objets qu'on va manipuler pour faire tourner le jeu :

Game : c'est le jeu. Elle initialise tout, lance une partie (qui se termine avec une victoire ou un nul), permet de jouer un tour, de chercher si la partie est finie, etc.
Player : ce sont les joueurs. Il doit y avoir 2 instances de cette classe lors d'une partie.
Board : c'est le plateau. Il doit y avoir une instance de cette classe lors d'une partie.
BoardCase : c'est une case. Il devrait y avoir 9 instances de cette classe lors d'une partie.

2 classes vont nous permettre d'organiser le programme :

Application : cette classe va nous permettre de lancer le jeu. Elle va faire une boucle infinie de parties (on joue tant que les joueurs veulent continuer) et lancer l'instanciation d'un Game.
Show : cette classe sera une sorte de view. Elle affichera l'état du plateau de jeu à un instant T.
2.2.3. Niveau "on veut réfléchir mais aide-nous un peu"
Commencez par reprendre les classes listées ci-dessus. Maintenant nous allons détailler un peu le rôle et le fonctionnement de chacune :

BoardCase : chacune des 9 instances de BoardCase correspond à l'état d'une case du plateau.
Variables d'instance : une Boardcase est définie par sa position (A1, B2, B3, etc.) et son contenu (Soit elle est vide, soit elle a comme valeur le string "x", soit elle a comme valeur le string "o").
Board : à l'initialisation du plateau, il doit instancier immédiatement 9 BoardCases (une par case).
Variables d'instance : le Board doit embarquer les 9 BoardCase du jeu afin de pouvoir les lire et les modifier facilement. Il faut les lui attribuer sous forme d'un array ou d'un hash. Aussi, il est utile de compter le nombre de coup joué pour identifier facilement si on arrive au 9ème coup sans vainqueur.
Méthodes : le Board va s'occuper de faire le lien entre les BoardCases et le Game : il change les valeurs des BoardCases (de " " à "x" ou "o") et vérifie en fonction de la combinaison des BoardCases si la partie est finie (= un joueur a gagné ou bien les 9 cases sont remplies sans vainqueur).
Player
Variables d'instance : un joueur a un nom (habile) et un symbole ("x" ou "o").
Game : cette classe s'occupe de gérer toute la partie. À l'initialisation elle crée 2 instances de Player, et 1 instance de Board.
Variables d'instance : tu peux lui rattacher les 2 players (sous forme d'un array), le Board, et des informations annexes comme "quel joueur doit jouer ?", "quel est le statut de la partie (en cours ? player1 a gagné ? etc.)", etc.
Méthodes : Game permet de jouer un tour (demande au joueur ce qu'il veut faire et rempli la case), s'occupe de finir la partie si un joueur a gagné et propose aux joueurs de faire une nouvelle partie ensuite.