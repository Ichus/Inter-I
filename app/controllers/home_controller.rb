class HomeController < ApplicationController
  def index
  end

  def show
    @idea = params[:idea]
    @relations = find_relations(@idea)
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

  def home_params
    params.permit(:idea)
  end
end
