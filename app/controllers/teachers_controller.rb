class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all.order(name: :asc)
  end

  def show
    @teacher = Teacher.friendly.find(params[:id])
  end
  
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to teachers_path }
      end
    else
      render :new, status: :bad_request
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name)
  end
end