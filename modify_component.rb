require "Watir"
require "./2009/utils.rb"
require "./2009/component_page.rb"

if __FILE__ == $0
	
	ie = Watir::Browser.new
	ie.speed = :zippy # options :slow :fast :zippy
	page = ComponentPage.new ie

	t1 = Time.now
	page.open Utils.get_component_url("tcm:5-54")
	t2 = Time.now
	delta = t2 - t1
	print "Opening ComponentView took " + delta.to_s + " seconds\n"

	page.modify_field("heading", "Testing Testing Testing Testing")
	page.modify_field("subheading", "bla bla bla")
	page.modify_rtf_field("summary", "Boom!")
	#page.add_component_link "image"
	t1 = Time.now
	page.save
	t2 = Time.now
	delta = t2 - t1
	print "Saving Component took " + delta.to_s + " seconds\n"
end