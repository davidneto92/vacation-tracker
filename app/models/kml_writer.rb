class KmlWriter
  FULL_MAP_START = File.open("kml_templates/01_boiler_start.xml", "r").read
  FULL_MAP_END   = File.open("kml_templates/02_boiler_end.xml", "r").read

  def self.write_kml(data, user_uid)
    time = Time.now.strftime("%d%m%Y")

    if Rails.env.test?
      file_path = "spec/fixtures/files/Visited_Parks_#{time}_#{user_uid}.kml"
    else
      file_path = "public/map_exports/Visited_Parks_#{time}_#{user_uid}.kml"
    end

    open(file_path, 'w'){ |f|
      f.puts FULL_MAP_START

      data.each do |park|
        f.puts "<Placemark>"
        f.puts "<name>#{park['full_name']}</name>"

        if park["visited"] == true
          f.puts "<description><![CDATA[Official NPS Site:<br>#{park['nps_url']}<br>Last visited on #{park['most_recent_visit_date']}]]></description>"
          f.puts "<styleUrl>#icon-1899-0F9D58</styleUrl>"
        else
          f.puts "<description><![CDATA[Official NPS Site:<br>#{park['nps_url']}]]></description>"
          f.puts "<styleUrl>#icon-1899-FFD600</styleUrl>"
        end

        f.puts "<Point><coordinates>#{park['longitude']},#{park['latitude']}</coordinates></Point>"
        f.puts "</Placemark>"
      end

      f.puts FULL_MAP_END
    }
    
    return [file_path, "Visited_Parks_#{time}_#{user_uid}.kml"]
  end

end
