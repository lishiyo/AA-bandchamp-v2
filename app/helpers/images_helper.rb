module ImagesHelper

  def add_images(target)
    html = "<button type='button' class='btn btn-info btn-upload btn-upload-header' data-toggle='modal' data-target="
    html += "#{target.to_s} >"
    html += (fa_icon "camera-retro").to_s
    html += '</button>'

    html.html_safe
  end

end
