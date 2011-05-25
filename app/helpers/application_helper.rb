module ApplicationHelper

	def logo
		logo = image_tag("hizzlepadlogo.png", :alt => "Sample App", :class => "round")
	end
	

  def title
    base_title = "HizzlePad v0.1"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end

