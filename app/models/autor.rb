class Autor < ActiveRecord::Base
	has_and_belongs_to_many  :onlinetexte
	has_many  :autorenlinks

  MONATSNAMEN = [nil, "Januar", "Februar", "M�rz", "April", "Mai", "Juni",
    "Juli", "August", "September", "Oktober", "November", "Dezember"]

  def zeigeNamen
    str = ""

    if vorname != nil then str = vorname end

    if str != "" && nachname != nil then
      str = nachname + ", " + str
    elsif nachname != nil then
      str = nachname
    end
    
    if (geburtsjahr != nil) && (todesjahr != nil) then
      str += " ("+zeigeGeburtsjahr+"-"+zeigeTodesjahr+")"
    elsif (geburtsjahr != nil) then
      str += " ("+zeigeGeburtsjahr+")"
    elsif (todesjahr != nil) then
      str += " (-"+zeigeTodesjahr+")"
    end
      
    return str
  end

  def zeigeGeburtsjahr
    if (geburtsjahr != nil)
      geburtsjahr.to_s+(!geburtsjahr_gesichert ? "?" : "")
    else
      return ""
    end
  end
  
  def zeigeTodesjahr
    if (todesjahr != nil)
      todesjahr.to_s+(!todesjahr_gesichert ? "?" : "")
    else
      return ""
    end
  end

  def zeigeTodesdatum
    return zeigeDatum(todesjahr, todesmonat, todestag, todesjahr_gesichert)
  end

  def zeigeGeburtsdatum
    return zeigeDatum(geburtsjahr, geburtsmonat, geburtstag, geburtsjahr_gesichert)
  end

  def zeigeDatum(jahr, monat=nil, tag=nil, gesichert=true)
    if jahr == nil then return "" end
    datum = jahr.to_s
    datum += "?" if !gesichert
    if monat != nil then
      datum = MONATSNAMEN[monat]+" "+datum
    end
    if tag != nil then
      datum = tag.to_s+". "+datum
    end
    return datum
  end
end
