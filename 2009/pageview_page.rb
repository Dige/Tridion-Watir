#TODO: make a base-class, duplicate code with component_page
class PageView_Page

	attr_accessor :navList, :fNavButtons

	def initialize(browser)
		@browser = browser
		@navList = @browser.frame(:id, 'fNavTop').frame(:id, 'fNavList')
		@fNavButtons = @browser.frame(:id, 'fNavTop').frame(:id, 'fNavButtons')
	end

	def open(url)
		@browser.goto url
		@navList.text_field(:id => "Title").wait_until_present #wait until page is fully loaded
	end

	def modify_title title
		@navList.text_field(:id => "Title").set title
	end

	def modify_filename filename
		@navList.text_field(:id => "txtFileName").set filename
	end

	def save
		#For Watir-webdriver
		#@fNavButtons.element(xpath: Nokogiri::HTML(@fNavButtons.html).css("[id = 'Apply']").first.path).click
		
		#for Watir
		cmd = "javascript:" + "top.mObjSYNC.gBoolSaving = true;"
	  	@browser.document.parentWindow.execScript(cmd)
	  	cmd = "javascript:" + "top.fNavTop.fNavButtons.CallSyncCmd('BtnApply');"
	  	@browser.document.parentWindow.execScript(cmd) 
	  	@browser.wait_until {!@browser.title.include? "*"} # wait until done saving
	end


end