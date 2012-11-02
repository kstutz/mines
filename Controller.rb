
class Controller
  require 'Board'
  require 'rubygems'
  require 'rubygame'
  
  @breite = 5
  @hoehe = 5
  @anzahl = 4
  
#TODO: hier muss es weitergehen mit dem Fenster und so
  @screen = Rubygame::Screen.new [640, 480], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
  @screen.title = "Huhu"

  gewonnen = false
  brett = Board.new(@breite,@hoehe,@anzahl)
  brett.minen_verteilen
  brett.nachbarn_finden
  puts ""
  brett.zeichnen3

  begin
    print "Zeile: "
    x = gets.chomp.to_i
    print "Spalte: "
    y = gets.chomp.to_i
    #TODO: Eingaben ueberpruefen!
    spielende = brett.aufdecken x-1,y-1
    brett.zeichnen3
    #TODO: Rausfinden, ob gewonnen oder verloren!
    #TODO: wenn gewonnen, dann ist nicht alles aufgedeckt!
    spielende=true if brett.alles_aufgedeckt?
  end until spielende == true
  
  puts 'Vorbei!'

  def zeichnen_echt

  end

end
