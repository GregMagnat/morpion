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
  