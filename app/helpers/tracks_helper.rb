module TracksHelper

  def ugly_lyrics(lyrics)
    html = "<pre style='text-align:center;'>"
    lyrics.split("\n").each do |line|
      html += "&#9835; #{line}\n"
    end
    html += "</pre>"

    html.html_safe
  end

end
