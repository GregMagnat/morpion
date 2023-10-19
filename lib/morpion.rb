#la classe Player permet de définir le joueur: son nom et son jeton
class Player
  attr_accessor :name, :mark

#initialise la classe Player avec les valeurs de bases, nom, symbole, grille
  def initialize(name, mark, board)
    @name = name
    @mark = mark
    @board = board
  end

#met à jour les cases en fonction de la valeur sélectionnée par le joueur
  def move(cell)
    @board.update_cell(cell, self.mark)
  end

#Recherche de toutes les combinaisons gagnantes !
#permet de faire une boucle sur toutes les combinaisons gagnantes et de s'assurer que les jetons sont bien identiques dans l'array (merci GPT)
  def winner?
    wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]]
    wins.each do |win|
      values = [cells[win[0]], cells[win[1]], cells[win[2]]]
      return true if values.include?(self.mark.to_s) &&
      ((values[0] == values[1]) && (values[1] == values[2]))
    end
    false
  end

  private
  
#Lier les celulles à la classe joueur
  def cells
    @board.cells
  end
end

#La j'attaque mon plateau .. 
class Board
  attr_accessor :cells
#Permet de mettre à jour le tableau en fonction des inputs du joueur tout en garatissant que la cellule soit vide
  def initialize
    @cells = [
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9"
    ]
  end

#Affichage du corps du tableau (valeurs de base + lignes verticales et horizontales)
  def update_cell(number, mark)
    if cell_free?(number)
      self.cells[number - 1] = mark.to_s
      show_board
    else
      puts "Déjà prise ! Choisis une autre case gogole."
      return false
    end
  end

#permet de limiter cette méthode à la classe Board  et les hline vline et cross permettent d'afficher mon tableau merci GPT
#Permet de remplacer les cellules par le signe du joueur en checkant si elles sont vides, sinon la cellule n'est pas complétée
  def show_board
    hline = "\u2502"
    vline = "\u2500"
    cross = "\u253C"
    row1 = " " + self.cells[0..2].join(" #{hline} ")
    row2 = " " + self.cells[3..5].join(" #{hline} ")
    row3 = " " + self.cells[6..8].join(" #{hline} ")
    separator = vline * 3 + cross + vline * 3 + cross + vline * 3
    system("clear")
    puts row1
    puts separator
    puts row2
    puts separator
    puts row3
  end

  private
#Permet de remplacer les cellules par le signe du joueur en checkant si elles sont vides, sinon la cellule n'est pas complétée
  def cell_free?(number)
    cell = self.cells[number - 1]
    if cell == "X" ||  cell == "O"
      false
    else
      true
    end
  end

end
#Cette classe permet de mettre en place le jeu et de le lancer avec des valeurs de base
class Game

  def initialize
    @board = Board.new
    @current_player = ""
    @winner = false
    @turn = 0
  end
#Méthode permettant de lancer le jeu et de démarrer la partie et déterminer l'issue de la partie. On crée de nouveaux joueurs avec des noms récupérés de la méthode 'get_names'.
  def start_game
    names = get_names
    @player1 = Player.new(names[0], :X, @board)
    @player2 = Player.new(names[1], :O, @board)
    @current_player = @player1
    @board.show_board
    turn until @winner || @turn == 9
    if @winner
      puts "#{@winner.name} Viiiiiiiiiictoire pour Griffondor!"
    else
      puts "Issou"
    end
  end

  private
 #le joueur peut entrer un nombre compris entre 1 et 9, si le nombre n'est pas compris dans cet intervalle un message s'affiche demandant de redonner une valeur.
  def turn
    puts "#{@current_player.name}\'s , Un chiffre entre 1 et 9 "
    choice = gets.chomp.to_i
    if choice > 9 || choice < 1
      puts "Hop hop hop, entre 1 et 9"
    elsif @current_player.move(choice) != false
      @winner = @current_player if @current_player.winner?
      @turn += 1
      switch_player
    end
  end
# Méthode permettant de mettre en place les changement de joueur
  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
#Méthode permettant d'obtenir le nom des joueurs, on utilise le gest.chomp
  def get_names
    puts "Player X pseudo: "
    name1 = gets.chomp
    puts "Player O pseudo: "
    name2 = gets.chomp
    [name1, name2]
  end

end

game = Game.new
game.start_game