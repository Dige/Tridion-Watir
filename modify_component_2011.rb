require "rubygems"
require "watir-webdriver"
require "2011/utils.rb"
require "2011/component_page.rb"


if __FILE__ == $0

	b = Watir::Browser.new(:chrome, :switches => ['--load-extension=D:\Development\WatirBenchmarking\2011\HTTPAuthExtension'] )
	component = ComponentPage.new b
	b.goto "http://username:password@192.168.0.1" #log in to prevent asking for credentials
	t1 = Time.now
	component.open Utils.get_new_component_url "tcm:756-24-2"
	t2 = Time.now
	delta = t2 - t1
	print "Opening ComponentView took " + delta.to_s + " seconds\n"
	component.title = "Testing"
	
	component.change_schema "tcm:756-14259-8"
	
	component.modify_field("Title", "Test Title")
	component.modify_field("Introduction", "Blablabla")
	component.add_external_link("Background", "http://www.google.com")
	component.modify_field("Subtitle", "Test Subtitle")
	component.modify_field("Title", "Test Paragraph Title", 1)
	component.modify_rtf_field("Text", "Test RTF text")
	component.select_dropdown_value("Position", "Right")
	component.insert_field("Paragraphs")
	component.modify_field("Title", "Test Second Paragraph Title", 2)
	component.modify_rtf_field("Text", "Test Second RTF text", 1)

	t1 = Time.now
	#component.save
	t2 = Time.now
	delta = t2 - t1
	print "Saving Component took " + delta.to_s + " seconds\n" 
end