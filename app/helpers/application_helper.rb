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

  def show_flash
    flash[flash_type]
  end

  def flash_type
    flash[:error] ? :error : :notice
  end

  def wrapped_flash
    show_flash and content_tag(:p, show_flash, :class => flash_type)
  end
end
