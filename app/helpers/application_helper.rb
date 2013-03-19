module ApplicationHelper

  def is_legacy?
    browser.ie6?
  end

end
