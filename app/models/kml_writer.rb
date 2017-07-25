class KmlWriter
  FULL_MAP_START = File.open("kml_templates/01_boiler_start.xml", "r").read
  FULL_MAP_END   = File.open("kml_templates/02_boiler_end.xml", "r").read

  def self.write_kml(data, user_uid)
    time = Time.now.strftime("%d%m%Y")

    kml_content = FULL_MAP_START

    data.each do |park|
      kml_content << "<Placemark>\n"
      kml_content << "<name>#{park['full_name']}</name>\n"
      if park["visited"] == true
        kml_content << "<description><![CDATA[Official NPS Site:<br>#{park['nps_url']}<br>Last visited on #{park['most_recent_visit_date']}]]></description>\n"
        kml_content << "<styleUrl>#icon-1899-0F9D58</styleUrl>\n"
      else
        kml_content << "<description><![CDATA[Official NPS Site:<br>#{park['nps_url']}]]></description>\n"
        kml_content << "<styleUrl>#icon-1899-FFD600</styleUrl>\n"
      end
      kml_content << "<Point><coordinates>\n#{park['longitude']},#{park['latitude']}\n</coordinates></Point>\n"
      kml_content << "</Placemark>\n"
    end

    kml_content << FULL_MAP_END

    file_name = "Visited_Parks_#{time}_#{user_uid}.kml"
    return [kml_content, file_name]
  end

end
