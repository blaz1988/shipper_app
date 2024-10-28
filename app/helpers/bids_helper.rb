module BidsHelper
  def flash_messages
    flash.map do |type, message|
      next if message.blank?

      css_class = case type.to_sym
                  when :notice then "flash-notice"
                  when :alert then "flash-alert"
                  else "flash-message"
                  end

      content_tag(:div, message, class: "#{css_class} flash-message")
    end.join.html_safe
  end
end
