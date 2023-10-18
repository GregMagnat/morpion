# Class Player avec joueur, plateau et symboles, donc "actions de bases" 
class Player
    attr_reader :name, :mark
  
    def initialize(name, mark, board)  #initie un nom de joueur, un symbole et le tableau !
      @name = name
      @mark = mark
      @board = board
    end
  
    def move(cell)  #permet au joueur de choisir une cellule pour jouer, mettant à jour la grille du jeu via la méthode update_cell
      @board.update_cell(cell, @mark)
    end
  
    def winner?   #controle la victoire d'un joueur avec l'ensemble des combinaisons ci-dessous
      wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]] # array avec ensemble des combi
      wins.any? do |win|  # controle d'un winner, grace à .any? do dans l'array win 
        win.all? { |cell| @board.cells[cell] == @mark } #vérifie toute les win grace {} (aide de gpt pour cette formule)
      end
    end
  end
  
  # Class Board concerne ma grille ! 
  class Board
    attr_accessor :cells
  
    def initialize #Première méthode pour les règles de mon tableau.
      @cells = (1..9).map(&:to_s)   #cette ligne de code crée un tableau de neuf éléments, petit coup de main par gpt
  
    def update_cell(number, mark)  méthode concernant le remplissage de mes 9 cases grace à une affectation de chiffre
      if cell_free?(number) #le if me permet de contoler si ma case et vide ou non afin de la remplir 
        @cells[number - 1] = mark.to_s
        show_board #permet de mettre à jour l'affichage de ma grille suite à la condition if 
      else
        puts "Cell not empty! Choose another cell."
        return false
      end
    end
  
    def show_board
      system("clear") || system("cls")
      puts "\n"
      puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]}"
      puts "-----------"
      puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]}"
      puts "-----------"
      puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]}"
      puts "\n"
    end
  
    private
  
    def cell_free?(number)
      cell = @cells[number - 1]
      cell != "X" && cell != "O"
    end
  end
  
  # Class Game
  class Game
    def initialize
      @board = Board.new
      @current_player = nil
      @winner = nil
      @turn = 0
    end
  
    def start_game
      names = get_names
      @player1 = Player.new(names[0], 'X', @board)
      @player2 = Player.new(names[1], 'O', @board)
      @current_player = @player1
      @board.show_board
      turn until @winner || @turn == 9
      if @winner
        puts "#{@winner.name} wins!"
      else
        puts "Draw!"
      end
    end
  
    private
  
    def turn
      puts "#{@current_player.name}'s turn. Choose your cell (1-9): "
      choice = gets.chomp.to_i
      if (1..9).cover?(choice)
        if @current_player.move(choice) != false
          @winner = @current_player if @current_player.winner?
          @turn += 1
          switch_player
        end
      else
        puts "Warning: Enter a number between 1 and 9."
      end
    end
  
    def switch_player
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end
  
    def get_names
      puts "Player X name: "
      name1 = gets.chomp
      puts "Player O name: "
      name2 = gets.chomp
      [name1, name2]
    end
  end
  
  game = Game.new
  game.start_game