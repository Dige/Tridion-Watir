module Utils
	def Utils.get_frontend_url
		#'http://username:password@192.168.0.1'
		'http://192.168.0.1'
	end

	def Utils.get_new_component_url folderUri
		Utils.get_frontend_url + '/WebUI/item.aspx?tcm=16#type=tcm:16&org=' + folderUri
	end

	def Utils.get_component_url uri
		Utils.get_frontend_url + '/WebUI/item.aspx?tcm=16#id=' + uri
	end
end