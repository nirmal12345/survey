class SurveynamesController < ApplicationController
  
  before_filter :require_admin_user, :except => ['index']
  
  #list all the surveys
  def index
    if current_user
      @current_user_roleid = current_user.role_id
      @surveynames = Surveyname.paginate :page => params[:page], :per_page => 10, :order => 'created_at DESC'
    else
      flash[:notice] = 'You are not authorized to view this content, please login as Admin'
      redirect_to root_path
    end
  end
  
  def new
    @surveyname = Surveyname.new
  end
  
  #create new survey
  def create
    @surveyname = Surveyname.new(params[:surveyname])
    @surveyname.user_id = current_user.id
    if @surveyname.save
      redirect_to surveynames_path, :notice => "survey successfully created!"
    else
      render :new
    end
  end
  
  #edit the survey
  def edit
    @surveyname = Surveyname.find(params[:id])
  end
  
  #update the survey
  def update
    surveyname = Surveyname.find(params[:id])
    if surveyname.update_attributes(params[:surveyname])
      redirect_to surveynames_path, :notice => "survey successfully updated!"
    else
      render :edit
    end
  end
  
  #delte the survey
  def destroy
    surveyname = Surveyname.find(params[:id])
    surveyname.destroy
    redirect_to surveynames_path
  end
end
