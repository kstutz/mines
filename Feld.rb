
class Feld
  def initialize
    @offen=false
  end

  def nachbarn=(array)
    @nachbarn = array
  end

  def nachbarn
    return @nachbarn
  end

  def finde_nachbarminenzahl
    anzahl = 0
    @nachbarn.each do |i|
      anzahl += 1 if i.mine?
    end
    @nachbarminenzahl = anzahl
  end

  def nachbarminenzahl
    return @nachbarminenzahl
  end

  def offen?
    return @offen
  end

  def offen=(bool)
    @offen=bool    
  end

  def mine?
    return @mine
  end
  
  def mine_setzen
    @mine=true
  end

end
