$(document).ready(function(){
	
	Dropzone.autoDiscover = false;
 
	var userDropzone = new Dropzone("#sub_dropzone", {
		maxFilesize: 5, // Set the maximum file size to 256 MB
		paramName: "image[attachment]", // Rails expects the file upload to be something like model[field_name]
		addRemoveLinks: true // Don't show remove links on dropzone itself.
	});	
	
	return userDropzone
		.on("success", function(file, response) {
			// set id as returned response.fileID
			$(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
			$(file.previewElement).addClass("dz-success");
		})
		.on("removedfile", function(file) {
			var id = $(file.previewTemplate).find('.dz-remove').attr('id'); 
			// make a DELETE ajax request 
			console.log("making ajax request to: " + id);
				$.ajax({
					type: 'delete',
					url: '/images/' + id,
					success: function(data){
						console.log(data.message);
					}
				});
		});
	
	
});
		
// 		var _this = this;
//     appendContent(responseText.attachment.url, responseText.id);
//     setTimeout(function(){
//       $('#myModal').modal('hide');
//       _this.removeAllFiles();
//     }, 1000);

	
// 	var appendContent = function(imageUrl, mediaId) {
// 		$("#dropzone_area").append('<div class="col-lg-4">' + 
// 			'<div class="thumbnail"><img src="' + imageUrl + '"/>' +
// 			'<div class="caption">' +
// 			'<input id="dropzone_area_" name="dropzone_area[]" value="' + mediaId +'" type="checkbox">' + 
// 			'</div>' +
// 			'</div></div>');

// 		$("#delete").removeAttr('disabled');
// 		$("#no-media").html("");
// 	};
// });


