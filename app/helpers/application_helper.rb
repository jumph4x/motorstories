module ApplicationHelper

  def is_legacy?
    browser.ie6?
  end

  def html_title
    methud = "html_title_#{controller.action_name}"
    title = if respond_to? methud
      send(methud)
    else
      'Built by Gearheads. For Gearheads.'
    end

    "#{title} | Motorstori.es"
  end

end
