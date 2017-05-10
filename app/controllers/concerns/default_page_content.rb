module DefaultPageContent
  extend ActiveSupport::Concern
  
  included do
    before_filter :set_title
  end
  
  def set_title
    @page_title = "Glipboard | Go Glip Yourself"
  end
end