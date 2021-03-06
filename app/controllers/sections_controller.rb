class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    @nodes   = @section.nodes.order(sort: :desc, id: :desc)
    node     = params[:category].nil? ? @nodes.first : @nodes.where(id: params[:category]).first

    return render_404 if node.nil?
    @topics  = node.topics.includes(:user).order(sort: :asc).page(params[:page])
  end
end
