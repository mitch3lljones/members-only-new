module ApplicationHelper
    def full_title(title = nil)
        base_title = "Members Only"
        if title
            "#{title} | #{base_title}"
        else
            base_title
        end
    end
end
