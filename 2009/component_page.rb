require "rubygems"
require "nokogiri"

class ComponentPage
	
	attr_accessor :navList, :fNavButtons

	def initialize(browser)
		@browser = browser
		@navList = @browser.frame(:id, 'fNavTop').frame(:id, 'fNavList')
		@fNavButtons = @browser.frame(:id, 'fNavTop').frame(:id, 'fNavButtons')
	end

	def open(url)
		@browser.goto url
		@navList.text_field(:id => 'Content_Field').wait_until_present #wait until page is fully loaded
	end

	def wait_until_loaded
		@navList.text_field(:id => 'Content_Field').wait_until_present
	end

	def save
		#For Watir-webdriver
		@fNavButtons.element(xpath: Nokogiri::HTML(@fNavButtons.html).css("[id = 'Apply']").first.path).click
		
		#for Watir
		#cmd = "javascript:" + "top.mObjSYNC.gBoolSaving = true;"
	  	#@browser.document.parentWindow.execScript(cmd)
	  	#cmd = "javascript:" + "top.fNavTop.fNavButtons.CallSyncCmd('BtnApply');"
	  	#@browser.document.parentWindow.execScript(cmd) 
	  	@browser.wait_until {!@browser.title.include? "*"} # wait until done saving
	end


	def modify_field(fieldName, value, index = 0)
		@navList.tr(:id => "Start_#{fieldName}", :index => index).text_field(:id => 'Content_Field').set value
	end

	def modify_rtf_field(fieldName, value, index = 0)
		#With Webdriver works correctly (i.e. source-tab is opened) with Watir source-tab is not opened but it still allows you modify the value
		@navList.tr(:id => "Start_#{fieldName}", :index => index).div(:id => 'Content_Field').span(:id => /_tab_source/).click
		#@navList.tr(:id => "Start_#{fieldName}").div(:id => 'Content_Field').span(:id => /_tab_source/).left_click
		@navList.tr(:id => "Start_#{fieldName}", :index => index).div(:id => 'Content_Field').text_field(:id => /_view_source/).set value
	end

	def add_component_link(fieldName)
		cmd = "javascript:" + "top.fNavTop.fNavList.SelectCompLink(document.getElementById('Field_#{fieldName}_btnAdd'), 'Field_image');"
		@browser.document.parentWindow.execScript(cmd)
		print @browser.modal_dialog.title
		#cmd = "javascript:" + "top.fNavTop.fNavList.SelectCompLink(this, 'Field_#{fieldName}');"
		#@browser.document.parentWindow.execScript(cmd)
	end

	def modify_title title
		@navList.text_field(:id => "Title").set title
	end

	def change_schema uri
		@navList.text_field(:id => "Schema").click
=begin
		#there is no sensible way to click items on the list as it is dynamically generated with JS
		sleep 1
		for i in 0..index
			@navList.send_keys :down
		end
=end
	end
end
