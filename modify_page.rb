require "Watir" 
require "./2009/pageview_page.rb"
require "./2009/utils.rb"

if __FILE__ == $0
	ie =  Watir::Browser.new
	pageView = PageView_Page.new ie
	pageView.open Utils.get_page_url  "tcm:6-498-64"

	pageView.modify_title "Club Sandwich test"
	pageView.modify_filename "club_sandwich_test"

	t1 = Time.now
	pageView.save
	t2 = Time.now
	delta = t2 - t1
	print "Saving Page took " + delta.to_s + " seconds\n"

end