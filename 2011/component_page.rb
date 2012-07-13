require "page-object"

class ComponentPage
	include PageObject

	text_field(:title, :id => 'Title')
	select_list(:schema, :id => 'Schema')

	def open(url)
		@browser.goto url
		@browser.wait_until { @browser.text_field(:id => 'Title').enabled? }
	end

	def change_schema uri
		schema_field = @browser.div(:id => 'Schema')
		schema_field.click
		sleep 1

		#Bug in ChromeDriver that frames contain wrong innerHTML
		#@browser.frame(:id => /dropdownpanel/).tr(:title => /#{titleOrUri}/).click 

		#Can't do this either due to the same bug (get's the correct element but click will fail)
		#@browser.execute_script("return window.document.getElementById('dropdownpanel_6_frame_details')
		#		.contentWindow.document.getElementById('item_#{uri}')").click

		#Nasty workaround. NOTE: this breaks if schema is pre-selected!!
		rowIndex = @browser.execute_script("return window.document.getElementById('dropdownpanel_6_frame_details')
				.contentWindow.document.getElementById('item_#{uri}').rowIndex")

		for i in 0..Integer(rowIndex)
			@browser.send_keys :down
		end

		@browser.div(:id => "SchemaBasedFields").div(:class => "field").wait_until_present
	end

	def modify_field(title, value, index = 0)
		@browser.label(:title => /#{title}/, :index => index).parent.text_fields[0].set value
	end

	def modify_rtf_field(title, value, index = 0)
		rtfField = @browser.label(:title => /#{title}/, :index => index).parent
		rtfField.td(:id => /tab_source/).click
		rtfField.text_field(:class => /SourceTab/).set value
	end

	def add_external_link(title, value, index = 0)
		@browser.label(:title => /#{title}/, :index => index).parent.div(:class => "button insert").click
		@browser.wait_until {@browser.window(:title => /Hyperlink/).exists?}
		@browser.window(:title => /Hyperlink/).use do
			browser.text_field(:id => "FieldUrl").set value
			browser.div(:id => "BtnOk").click
		end
	end

	def select_dropdown_value(title, value, index = 0)
		@browser.label(:title => /#{title}/, :index => index).parent.select_lists[0].select(value)
	end

	def insert_field(title, index = 0)
		@browser.label(:title => /#{title}/, :index => index).parent.div(:title => "Insert").click
	end
	
	def save
		#@browser.table(:id => "HomePage_switch").click
		#the line below causes some weird behaviour
		@browser.text_field(:id => "Title").click
		
		@browser.div(:id => 'SaveBtn' ).click
		@browser.wait_until {!@browser.title.include? self.title}
	end

end
