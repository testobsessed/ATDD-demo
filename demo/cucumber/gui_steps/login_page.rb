class LoginPage
  attr :page
  
  def initialize(page_handle)
    @page = page_handle
    @page.open "/"
  end
  
  def login(username, password)
    @page.open "/"
    @page.click "login"
    @page.type "uname", username
    @page.type "pwd", password
    @page.click "submit_button"
  end
  
  def create(username, password)
    @page.open "/"
    @page.click "create"
    @page.type "uname", username
    @page.type "pwd", password
    @page.click "submit_button"
  end
  
  def get_message
    @page.get_text "message"
  end
  
end