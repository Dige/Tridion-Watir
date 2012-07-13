require "rubygems"
require "watir-webdriver"
require "2011/utils.rb"
require "2011/component_page.rb"
require "2011/cme_page.rb"

if __FILE__ == $0

	b = Watir::Browser.new(:chrome, :switches => ['--load-extension=D:\Development\WatirBenchmarking\2011\HTTPAuthExtension'] )
	
	cme = CmePage.new b

	cme.open "http://username:password@192.168.0.1" #log in
	cme.open Utils.get_frontend_url #open the page again to prevent problems with having the credentials in URL
	cme.switch_tab DashboardTabs::Home::Name

	cme.expand_node "tcm:0-14-1"
	cme.open_node "tcm:0-14-1"
	cme.open_node "tcm:14-24-2"
	sleep 1
	cme.open_item "Content"
	sleep 1
	cme.open_item "Articles"
	cme.switch_tab DashboardTabs::Create::Name
	sleep 1
	cme.click_dashboard_button DashboardTabs::Create::Buttons::NewComponent

	b.wait_until {b.window(:title => /Component/).exists?}
	b.window(:title => /Component/).use do
		component = ComponentPage.new b

		component.title = "Testing"
		component.modify_field("Title", "Test Title")
		component.modify_field("Introduction", "Blablabla", 1) 
		component.add_external_link("(visual)", "http://www.google.com")
		component.modify_field("Title", "Test Paragraph Title", 1)
		component.modify_rtf_field("Text", "Test RTF text")
		component.select_dropdown_value("Position", "Right")
	end

end