class HomeController < ApplicationController
  def index
  end

  def show
    @idea = params[:idea]
    @relations = find_relations(@idea)
    @categories = find_categories(@idea)
  end

  def find_relations(idea)
    nodey = Neo4j::Node.find("idea: #{idea.inspect}")
    if nodey.first
      node = nodey.first
      nodey.close
      relations = []
      node.outgoing(:relation).filter{|path| path.relationships.first[:weight] > 0.7515 && !/#{node[:idea]}/i.match(path.end_node[:idea]) }.each {|rel| relations << rel[:idea] }
      relations
    else
      false
    end
  end

  def find_categories(idea)
    categories = []
    nodey = Neo4j::Node.find("idea: #{idea.inspect}~")
    if nodey.first
      node = nodey.first
      nodey.close
      node.rels.each do |rel|
        category = rel["category"]
        category_flag = category.chars.first.to_i
        category = category.slice(1..-1)
        already_found = false
        categories.each { |cat| already_found = true if cat[1].eql? category }
        categories << [category_flag, category] unless already_found
      end
      categories
    else
      false
    end
  end

  def home_params
    params.permit(:idea, :category)
  end
end
