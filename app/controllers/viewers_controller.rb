class ViewersController < ApplicationController
  before_action :current_user_must_be_viewer_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_viewer_user
    viewer = Viewer.find(params[:id])

    unless current_user == viewer.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Viewer.ransack(params[:q])
    @viewers = @q.result(:distinct => true).includes(:user, :restaurant).page(params[:page]).per(10)

    render("viewers/index.html.erb")
  end

  def show
    @viewer = Viewer.find(params[:id])

    render("viewers/show.html.erb")
  end

  def new
    @viewer = Viewer.new

    render("viewers/new.html.erb")
  end

  def create
    @viewer = Viewer.new

    @viewer.user_id = params[:user_id]
    @viewer.restaurant_id = params[:restaurant_id]

    save_status = @viewer.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/viewers/new", "/create_viewer"
        redirect_to("/viewers")
      else
        redirect_back(:fallback_location => "/", :notice => "Viewer created successfully.")
      end
    else
      render("viewers/new.html.erb")
    end
  end

  def edit
    @viewer = Viewer.find(params[:id])

    render("viewers/edit.html.erb")
  end

  def update
    @viewer = Viewer.find(params[:id])

    @viewer.user_id = params[:user_id]
    @viewer.restaurant_id = params[:restaurant_id]

    save_status = @viewer.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/viewers/#{@viewer.id}/edit", "/update_viewer"
        redirect_to("/viewers/#{@viewer.id}", :notice => "Viewer updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Viewer updated successfully.")
      end
    else
      render("viewers/edit.html.erb")
    end
  end

  def destroy
    @viewer = Viewer.find(params[:id])

    @viewer.destroy

    if URI(request.referer).path == "/viewers/#{@viewer.id}"
      redirect_to("/", :notice => "Viewer deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Viewer deleted.")
    end
  end
end
