class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_should_be_admin, only: [:new, :create, :destroy]

  def edit
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:id])
  end

  def update
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:id])
    
    if @classroom.update(classroom_params)
      redirect_to teacher_url(@teacher)
    else
      render :edit, status: :bad_request
    end
  end

  def new
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = @teacher.classrooms.build
  end

  def create
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = @teacher.classrooms.build(classroom_params)

    if @classroom.save
      flash.now[:notice] = "Classroom created successfully"
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to teacher_url(@teacher)}
      end
    else
      flash.now[:alert] =  "Couldn't create classroom. Please check the form for details"
      render :new, status: :bad_request
    end
  end

  def destroy
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:id])

    if @classroom.delete
      flash.now[:notice] = "Classroom deleted successfully"
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to teacher_url(@teacher)}
      end
    else
      flash.now[:alert] = "Couldn't delete classroom"
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :section, :term)
  end
end