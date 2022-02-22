class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @teachers = Teacher.all.order(name: :asc)
  end

  def show
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      flash.now[:notice] = "User account edited successfully"
      redirect_to teachers_url
    else
      render :edit, status: :bad_request
    end
  end
  
  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash.now[:notice] = "Teacher's account added successfully"
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to teachers_path }
      end
    else
      flash.now[:alert] = "Couldn't add teacher's account. Please check the form for details"
      render :new, status: :bad_request
    end
  end

  def destroy
    Classroom.where(teacher: @teacher).each do |classroom|
      SubjectAssessment.where(teacher: @teacher, classroom: classroom).each do |s_a|
        s_a.delete
      end
      classroom.delete
    end
    if @teacher.delete
      flash.now[:notice] = "Teacher's account deleted successfully"
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to teachers_url}
      end
    else
      flash.now[:alert] = "Couldnt't delete teacher's account. Try once again."
      render :index, bad: :request
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name)
  end

  def set_teacher
    @teacher = Teacher.friendly.find(params[:id])
  end
end