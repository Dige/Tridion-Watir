require "watir-webdriver" #Watir is faster but can't seem to be able to handle iframes properly :(
require "./2009/cme_page.rb"
require "./2009/utils.rb"
require "./2009/component_page.rb"


if __FILE__ == $0
	t1 = Time.now
	ie =  Watir::Browser.new :ie
	cme_page = CmePage.new ie
	cme_page.open Utils.get_frontend_url
	cme_page.change_view Views::WebSiteManagement
	
	webView = cme_page.get_tree_view TreeViews::WebSiteManagement
	cme_page.expand_node('tcm:0-7-1', webView.html, webView) #TODO: Optimize the XPath to the root-element so there is less HTML to parse
	cme_page.expand_node('tcm:7-2-2', webView.html, webView)
	cme_page.expand_node('tcm:7-27-2', webView.html, webView)
	cme_page.open_node('tcm:7-39-2', webView.html, webView)

	t2 = Time.now
	delta = t2 - t1
	print "Opening folder took " + delta.to_s + " seconds\n"

	cme_page.create ItemTypes::Component

	ie.window(:url => /URI=New/).wait_until_present
	ie.window(:url => /URI=New/).use do
		page = ComponentPage.new ie

		navTop = ie.frame(:id, 'fNavTop')
		page.fNavButtons = navTop.frames[1] # Has to be set manually with an index because with ID it crashes
		page.navList = navTop.frames[4] # same as above
		page.modify_title "Test Component"
		#doesn't work, clicks the field but unable to select anything
		#page.change_schema "tcm:7-619-8"
		page.modify_field("heading", "Testing Testing Testing Testing")
		page.modify_field("subheading", "bla bla bla")
		page.modify_rtf_field("summary", "Boom!")
		#page.save
	end

	#cme_page.open_item "tcm:7-54"
	#TODO: Figure out how to handle modal dialogs

end