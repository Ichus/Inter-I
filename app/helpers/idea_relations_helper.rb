module IdeaRelationsHelper
  def nest_category_list(categories, cat_param, idea)
    output = ""
    last_level = 0
    @idea = idea

    categories = prep_nested categories

    categories.reverse_each do |item|
      if categorical_relations(item[1], @idea)
        level = item[0]
        text = item[1]

        active = true if cat_param == text

        if level == last_level
          output += "</li>"
        elsif level > last_level
          output += "<ul>"
        elsif last_level > level
          output += "</li>"
          output += "</ul></li>" * (last_level - level)
        end

        if active && level != 0
          output += "<li class='active tab-#{level}'>#{link_to text, show_categorical_relations_path(idea: @idea, category: text, followed_link: "Cat:#")}"
        else
          output += "<li class='tab-#{level}'>#{link_to text, show_categorical_relations_path(idea: @idea, category: text, followed_link: "Cat:")}"
        end
        last_level = level
      end
    end

    output += "</li></ul>" * last_level
    output.html_safe
  end

  def prep_nested(categories)
    count = -1
    begin
      count += 1
    end while categories[count][0] != 0

    (count + 1).times do
      reorder_array = categories.shift
      categories << reorder_array
    end
    categories
  end

  def list_idea_path
    if session[:idea_path].length > 2
      output = ""

      session[:idea_path].pop(2) if session[:idea_path].last == session[:idea_path][-3] && !params[:followed_link]

      output += "<h5>Here to There</h5>"
      output += "<ul>"
      session[:idea_path].each do |idea|
        output += "<li>#{link_to idea, show_relations_path(idea: idea, prev_followed_link: idea)}</li>"
      end
      output += "</ul>"

      output.html_safe
    end
  end

  # def collapse?(tab, list_level, list, active_category)
  #   case tab
  #   when 0
  #     return true
  #   when 1
  #     return true
  #   when 2, 3
  #     list_sub_category?(list_level, list, active_category)
  #     true
  #   else
  #     "error in home_helper.rb method not_collapsed"
  #   end
  # end
  #
  # def list_sub_category?(list_level, list, active_category)
  #   if active_category
  #     @lower_bound = []
  #     list.each do |level, num_tab|
  #       @upper_bound = level if num_tab == 1 && level < list_level
  #       @lower_bound << level if num_tab == 1 && level > list_level
  #     end
  #     if @upper_bound && @lower_bound[0]
  #       list_level.between?(@upper_bound, @lower_bound[0]) && active_category.between?(@upper_bound - 1, @lower_bound[0] + 1)
  #     elsif @upper_bound
  #       list_level > @upper_bound && active_category > @upper_bound
  #     else
  #       false
  #     end
  #   end
  # end

end
