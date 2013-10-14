module ApplicationHelper

  def is_legacy?
    browser.ie6?
  end

  def html_title
    methud = "html_title_#{controller.action_name}"
    title = if respond_to? methud
      send(methud)
    else
      "Built by Gearheads - For Gearheads"
    end

    "#{title} | Motorstori.es"
  end

  def show_flash
    flash[flash_type]
  end

  def flash_type
    flash[:error] ? :error : (flash[:notice] ? :notice : :alert)
  end

  def wrapped_flash
    return unless show_flash
    css_classes = {
      :error => 'alert'
    }

    content_tag :div, :class => 'flash', :'data-alert' => true do
      content_tag :div, :class => [flash_type, 'alert-box', 'row'] do
        (
          show_flash +
          content_tag(:a, "&times;".html_safe, class: 'close')
        ).html_safe
      end
    end
  end
end
