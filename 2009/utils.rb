module Utils
	def Utils.get_frontend_url
		'http://tridion.globaldeli.com'
	end

	def Utils.get_component_url uri
		Utils.get_item_url(uri, "16")
	end

	def Utils.get_page_url uri
		Utils.get_item_url(uri, "64")
	end

	def Utils.get_folder_url uri
		Utils.get_item_url(uri, "2")
	end

	def Utils.get_item_url(uri,type)
		Utils.get_frontend_url + "/Default.asp?URI=#{uri}&CONTEXTURI=&FILTER=Data&ITEMTYPE=#{type}&MODE"
	end
end