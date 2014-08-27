module ApplicationHelper
  def html_title
    methud = "title_#{controller.controller_name}_#{controller.action_name}"
    title = if respond_to? methud
      send(methud)
    else
      "Built by Gearheads - For Gearheads"
    end

    "#{title} | Motorstori.es"
  end

  def inline_svg path
    file = File.open("app/assets/images/#{path}", "rb")
    raw file.read
  end

  def show_flash
    flash[flash_type]
  end

  def flash_type
    flash[:error] ? :error : (flash[:notice] ? :notice : :alert)
  end

  def register_link
    if stored_vehicle_ids.any?
      link_to "Register #{content_tag :b, stored_vehicle_ids.count, class: 'label radius'}".html_safe, new_user_registration_path, :title => "Register now to save your projects!"
    else
      link_to "Register", new_user_registration_path
    end
  end

  def wrapped_flash
    return unless show_flash

    content_tag :div, :class => 'flash', :'data-alert' => true do
      content_tag :div, :class => [flash_type, 'alert-box', 'row'] do
        (
          show_flash +
          content_tag(:a, "&times;".html_safe, class: 'close')
        ).html_safe
      end
    end
  end

  def project_path vehicle, opts = {}
    semantic_vehicle_path vehicle.semantic_url_hash, opts
  end
end
