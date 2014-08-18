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

  def not_collapsed(tab, list_level, list, active_category)
    case tab
    when 0
      return true
    when 1
      return true
    when 2
      collapse?(tab, list_level, list, active_category)
    when 3
      return true
    else
      "error in home_helper.rb method not_collapsed"
    end
  end

  def collapse?(tab, list_level, list, active_category)
    list.each do |level, num_tab|
      case num_tab
      when 1
        @previous_tab_one = @tab_one
        @tab_one = level if level <= list_level
      when 2
        @tab_two = level
      end
      return true if level == list_level && @tab_one == active_category
      return true if @tab_one == active_category
    end
    return false
  end
end
