class JobsController < ApplicationController

  def index
    @jobs=Job.all.job('created_at DESC')
  end

  def new
    session[:job_params] ||= {}
    @job = Job.new(session[:job_params])
    @job.current_step = session[:job_step]
  end

  def create
    session[:job_params].deep_merge!(params[:job]) if params[:job]
    @job = Job.new(session[:job_params])
    @job.current_step = session[:job_step]
    if @job.valid?
      if params[:back_button]
        @job.previous_step
      elsif @job.last_step?
        @job.save if @job.all_valid?
      else
        @job.next_step
      end
      session[:job_step] = @job.current_step
    end
    if @job.new_record?
      render "new"
    else
      session[:job_step] = session[:job_params] = nil
      flash[:notice] = "job saved!"
      redirect_to @job
    end
  end


  def preview
    @job = Job.find(params[:id])
  end


  def show
    @job = Job.find(params[:id])
  end

  private
    def job_params
      params.require(:job).permit(:job_title, :headquarters, :description, :apply, :name, :url, :email, :highlight,:category_id, :logo)
    end
end
