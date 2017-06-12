class KmlWriter

  def self.write_kml(data)
    time = Time.now.strftime("%d%m%Y_%H%M")
    open("#{time}.kml", 'w'){ |f|
      f.puts "#{data}"
    }
  end

end
