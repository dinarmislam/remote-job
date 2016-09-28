class JobsController < ApplicationController

  def index
    @jobs=Job.all.order('created_at DESC')
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job
    else
      render 'new'
  end

  def show
    @job = Job.find(params[:id])
  end

  private
    def job_params
      params.require(:job).permit(:job_title, :headquarters, :description, :apply, :name, :url, :email, :highlight)
    end
end
