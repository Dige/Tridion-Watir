require "rubygems"
require "nokogiri" #To improve the performance of watir-webdriver

module Views
	ContentManagement = 2
	EmailManagement = 3
	WebSiteManagement = 4
	SearchView = 5
	SystemAdministration = 6
	MyTasks = 7
end

module TreeViews
	Search = 1
	Taxonomy = 2
	ContentManagement = 3
	EmailManagement = 4
	WebSiteManagement = 5
	SystemAdministration = 6
	MyTasks = 7
end

module ItemTypes
	Folder = "Folder"
	VirtualFolder = "VirtualFolder"
	Schema = "Schema"
	SG = "StructureGroup"
	TBB = "TemplateBuildingBlock"
	Component = "Component"
	MMComponent = "MMComponent"
	CT = "ComponentTemplate"
	PT = "PageTemplate"
	TargetGroup = "TargetGroup"

end


class CmePage
	def initialize(browser)
		@browser = browser
		navTopFrame = @browser.frame(xpath: "/html/body/iframe")
		@navTreeFrame = navTopFrame.frame(xpath: "html/frameset/frameset/frame")
		navList = navTopFrame.frame(xpath: "/html/frameset/frameset/frameset/frame[2]")
		listView = navList.frame(xpath: "/html/body/div[1]/iframe")
		@itemListView = listView.element(xpath: "/html/body/div[2]/table/tbody")
		@fNavButtons = navTopFrame.frame(xpath: "/html/frameset/frameset/frameset/frame[1]")
	end

	def open url
		@browser.goto url
	end

	#TODO: check if this can be used to collapse as well
	def expand_node(uri, html, root)
		root.td(xpath: Nokogiri::HTML(html).css("td[id = 'tgl_#{uri}']").first.path).click
	end

	def open_node(uri, html, root)
		root.td(xpath: Nokogiri::HTML(html).css("td[name = 'title_#{uri}']").first.path).click
	end

	def open_item_when_present(uri)
		@itemListView.tr(:id => uri).wait_until_present
		open_item uri
	end

	def open_item(uri)
		@itemListView.tr(:id => uri).double_click
	end

	def change_view(viewIndex)
		@navTreeFrame.element(xpath: "/html/body/div/div[3]/div[#{viewIndex}]").click
	end

	def get_tree_view(viewIndex)
		return @navTreeFrame.frame(xpath: "/html/body/div/div[2]/div[#{viewIndex}]/div/iframe")
	end

	def create(itemType)
		@fNavButtons.element(xpath: Nokogiri::HTML(@fNavButtons.html).css("[id = 'New#{itemType}']").first.path).click
	end
end