
class Board

  require 'Feld'

  def initialize(breite,hoehe,anzahl)
    @breite = breite
    @hoehe = hoehe
    @minenzahl = anzahl
    @felder = Array.new(@hoehe){Array.new(@breite)}
    @felder.map!{|i| i.map! {|j| j=Feld.new}}
  end

  # minen zufaellig auf Felder verteilen
  def minen_verteilen
    @minenzahl.times do
      x = rand(@hoehe)
      y = rand(@breite)
      @felder[x][y].mine? ? redo : @felder[x][y].mine_setzen 
    end
  end

  # Nachbarfelder finden und in Feld.nachbarn speichern
  def nachbarn_finden
    0.upto(@hoehe-1) do |i|
      0.upto(@breite-1) do |j|
        nachbarn = Array.new
        if (i>0 && j>0)
          nachbarn.push(@felder[i][j-1])
          nachbarn.push(@felder[i-1][j])
          nachbarn.push(@felder[i-1][j-1])
        end
        if (i<@hoehe-1 && j<@breite-1)
          nachbarn.push(@felder[i][j+1])
          nachbarn.push(@felder[i+1][j])
          nachbarn.push(@felder[i+1][j+1])
        end      
        if (i>0 && j<@breite-1)
          nachbarn.push(@felder[i-1][j+1])
          nachbarn.push(@felder[i][j+1])
          nachbarn.push(@felder[i-1][j])
        end
        if (i<@hoehe-1 && j>0)
          nachbarn.push(@felder[i+1][j-1])
          nachbarn.push(@felder[i+1][j])
          nachbarn.push(@felder[i][j-1])
        end
        nachbarn.uniq!
        @felder[i][j].nachbarn=(nachbarn)
        @felder[i][j].finde_nachbarminenzahl
      end
    end
  end

  
  def aufdecken(x,y)
    feld = @felder[x][y]
    feld.offen=true
    if feld.mine?
      alles_aufdecken
      return true
    end
    nachbarn_aufdecken feld if feld.nachbarminenzahl == 0
    return false
  end

  def nachbarn_aufdecken(feld)
    for nb in feld.nachbarn
      if !nb.offen?
        nb.offen=true
        nachbarn_aufdecken(nb) if nb.nachbarminenzahl == 0
      end
    end
  end

  def alles_aufdecken
    0.upto(@hoehe-1) do |i|
      0.upto(@breite-1) do |j|
        @felder[i][j].offen=true
      end
    end
  end

  def alles_aufgedeckt?
    0.upto(@hoehe-1) do |i|
      0.upto(@breite-1) do |j|
        return false if !@felder[i][j].offen?
      end
    end
    return true
  end

  #Spielfeld zeichnen 
  def zeichnen
    0.upto(@hoehe-1) do |i|
      0.upto(@breite-1) do |j|
        print '|'
        @felder[i][j].mine? ? print("x") : print(".")
      end
      puts '|'
    end
  end 


  def zeichnen2
    0.upto(@hoehe-1) do |i|
      0.upto(@breite-1) do |j|
        print '|'
        @felder[i][j].mine? ? print("x") : print(@felder[i][j].nachbarminenzahl)
      end
      puts '|'
    end
  end 


  def zeichnen3
    0.upto(@hoehe-1) do |i|
      0.upto(@breite-1) do |j|
        print '|'
        if @felder[i][j].offen? 
          @felder[i][j].mine? ? print("x") : print(@felder[i][j].nachbarminenzahl)
        else
          print(".")
        end
      end
      puts '|'
    end
  end

end
