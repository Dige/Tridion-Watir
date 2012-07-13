require "Watir" 
require "./2009/folder_page.rb"
require "./2009/utils.rb"

if __FILE__ == $0
	ie =  Watir::Browser.new
	folder = Folder_Page.new ie
	folder.open Utils.get_folder_url  "tcm:5-39-2"

	folder.modify_title "030_Sandwiches_test"

	t1 = Time.now
	folder.save
	t2 = Time.now
	delta = t2 - t1
	print "Saving folder took " + delta.to_s + " seconds\n"

end