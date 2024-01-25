module ApplicationHelper
    def display_errors(model, attribute)
        if model.errors[attribute].any?
          content_tag(:div, model.errors.full_messages_for(attribute).join(", "), class: "text-danger")
        end
    end
end
