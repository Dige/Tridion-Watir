#Tabs at the top of the screen
module DashboardTabs

	module Dashboard 
		Name = "Dashboard"
		module Buttons
			#TODO: add buttons
		end
	end

	module Home
		Name = "Home"
		module Buttons
			Cut = "CutBtn"
			Copy = "CopyBtn"
			Paste = "PasteBtn"

			Open = "OpenBtn"
			ShowBlueprintHierarchy = "BlueprintHierarchyBtn"
			ShowWhereUsed = "WhereUsedBtn"
			ShowProperties = "PropertiesBtn"
			Delete = "DeleteBtn"

			Compare = "CompareBtn"
			History = "HistoryBtn"
			CheckIn = "CheckInBtn"
			CheckOut = "CheckOutBtn"
			UndoCheckOut = "UndoCheckOutBtn"

			ShowPublishingQueue = "PublishingQueueBtn"
			Publish = "PublishBtn"
			Unpublish = "UnPublishBtn"

			SendToMyFavourites = "AddUriBtn"
			SendByEmail = "SendUriBtn"
		end
	end

	module Create 
		Name = "Create"
		module Buttons
			NewComponent = "NewComponentBtn1"
			#TODO: Handle these two special cases
			#NewMultimediaComponent = "NewMultimediaComponentCMI2"
			#UploadMultimediaComponent = "NewBasicMultimediaComponentCMI2"
			NewPage = "NewPageBtn1"
			NewCustomPage = "NewCutomPageBtn" #There is a typo in CM (at least in GA)

			NewPublication = "NewPublicationBtn"
			NewFolder = "NewFolderbtn1"
			NewStructureGroup = "NewStructureGroupBtn"
			NewVirtualFolder = "NewVirtualFolderBtn"

			NewSchema = "NewSchemaBtn"
			NewComponentTemplate = "NewComponentTemplateBtn"
			NewPageTemplate = "NewPageTemplateBtn"
			NewTemplateBuildingBlock = "NewTemplateBuildingBlockBtn"

			NewCategory = "NewCategoryBtn"
			NewKeyword = "NewKeywordBtn"

			NewTargetGroup = "NewTargetGroupBtn"
		end
	end

	module Organize 
		Name = "Organize"
		module Buttons
			ShowBlueprintHierarchy = "BlueprintHierarchyBtn1"
			Localize = "LocalizeBtn"
			Unlocalize = "UnLocalizeBtn"

			Classify = "OPClassifyBtn"
			Unclassify = "OPUnclassifyBtn"
			Reclassify = "OPReclassifyBtn"
			NewCategory = "NewCategoryBtn1"
			NewKeyword = "NewKeywordBtn1"

			ShowWhereUsed = "WhereUsedBtn1"
			ShowProperties = "PropertiesBtn1"
		end
	end

	module Workflow 
		Name = "Workflow"
		module Buttons
			#TODO: add buttons
		end
	end

	module EmailManagement 
		Name = "EmailManagement"
		module Buttons
			#TODO: add buttons
		end
	end

	module AudienceManagement 
		Name= "AudienceManagement"
		module Buttons
			#TODO: add buttons
		end
	end
	
	module Administration 
		Name = "Administration"
		module Buttons
			#TODO: add buttons
		end
	end

	module Tools 
		Name = "Tools"
		module Buttons
			OpenTemplateBuilder = "TemplateBuilderBtn"
			OpenWithTemplateBuilder = "OpenWithTemplateBuilderBtn"
			OpenContentPorter = "ContentPorterBtn"
		end
	end
end

#Buttons at bottom-left corner
module TaskbarButtons
	ContentManagement = "ContentManagement"
	SystemAdministration = "SystemAdministration"
end

class CmePage

	def initialize(browser)
		@browser = browser
		@publication_tree = @browser.frames[0] #getting frame with id return wrong frame for some reason
		@item_list = @browser.frames[8]
		@dashboard_toolbar = @browser.div(:id => "DashboardToolbar")
	end

	def open url
		@browser.goto url
	end

	def switch_tab tab
		@dashboard_toolbar.element(:id => "#{tab}Page_switch").click
	end

	def expand_node uri
		@publication_tree.div(:id => "node_#{uri}").div(:class => /line control/).click
	end

	def open_node uri
		@publication_tree.div(:id => "node_#{uri}").div(:class => "title").click
	end

	def select_item title
		@item_list.tr(:title => /#{title}/).click
	end

	def open_item title
		@item_list.tr(:title => /#{title}/).double_click
	end

	def click_dashboard_button button
		@dashboard_toolbar.div(:id => button).click
	end

end