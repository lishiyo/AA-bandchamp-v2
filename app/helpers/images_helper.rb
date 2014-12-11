module ImagesHelper

	def add_images(target, size)
		# class='btn btn-info btn-upload btn-upload-header'
		# type='button' 
		html = "<a href data-toggle='modal' style='color: magenta; font-size: #{size}em;' data-target="
    html += "#{target.to_s} >"
    #html += (fa_icon "camera-retro").to_s
		html += ("<i class=\"fa fa-fw fa-camera-retro\"></i>").html_safe
    html += '</a>'

    html.html_safe
  end
	
	def add_edit_icon(target, size)
		# <button type="button" class="btn btn-info btn-upload btn-edit-header" data-toggle="modal" data-target="#modal_edit_album">edit info</button>
		html = "<a href data-toggle='modal' style='font-size: #{size}em;' data-target="
		html += "#{target.to_s} >"
		html += ("<i class=\"fa fa-lg fa-pencil-square-o\ header-edit-btn\"></i>").html_safe
		html += '</a>'
		
		html.html_safe
	end

end
