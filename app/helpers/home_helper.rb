module HomeHelper
  def relations?(idea)
    nodey = Neo4j::Node.find("idea: #{idea.inspect}")
    if nodey.first
      node = nodey.first
      nodey.close
      relations = []
      node.outgoing(:relation).filter{|path| path.relationships.first[:weight] > 0.7515 && !/#{node[:idea]}/i.match(path.end_node[:idea]) }.each {|rel| relations << rel[:idea] }
      !!relations.first
    end
  end

  def categorical_relations(category, idea)
    nodey = Neo4j::Node.find("idea: #{idea.inspect}")
    if nodey.first
      node = nodey.first
      nodey.close
      relations = []
      node.outgoing(:relation).filter do |path|
        path.relationships.first[:weight] > 0.55 &&
        /#{category}/.match(path.relationships.first[:category]) &&
        !/#{node[:idea]}/i.match(path.end_node[:idea])
      end.first(10).each { |rel| relations << rel[:idea] }
      relations.length > 1 ? relations : false
    else
      false
    end
  end

  def nest_category_list(categories, cat_param, idea)
    output = ""
    last_level = 0
    @idea = idea
    @active = false

    categories.reverse_each do |item|
      if categorical_relations(item[1], @idea)
        level = item[0]
        text = item[1]

        @active = false if level == 1
        @active = true if cat_param == text

        if level == last_level
          output += "</li>"
        elsif level > last_level
          output += "<ul>"
        elsif last_level > level
          output += "</li>"
          output += "</ul></li>" * (last_level - level)
        end

        if @active && level != 0
          output += "<li class='active tab-#{level}'>#{link_to text, show_category_relations_path(idea: @idea, category: text)}"
        else
          output += "<li class='tab-#{level}'>#{link_to text, show_category_relations_path(idea: @idea, category: text)}"
        end
        last_level = level
      end
    end

    output += "</li></ul>" * last_level
    output.html_safe
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
