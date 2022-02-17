class SubjectAssessmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_should_be_admin, except: [:index]

  def index
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject_assessments = @teacher.classrooms.find(params[:classroom_id]).subject_assessments.order(created_at: :desc)
  end

  def edit
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject_assessment = SubjectAssessment.find(params[:id])
  end

  def update
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject_assessment = SubjectAssessment.find(params[:id])

    if @subject_assessment.update(subject_assessment_params)
      respond_to do |format|
        format.html {redirect_to teacher_classroom_subject_assessments_path(@teacher, @classroom, @subject_assessment)}
      end
    else
      render :edit, status: :bad_request
    end
  end

  def new
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject_assessment = SubjectAssessment.new
  end

  def create
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject_assessment = SubjectAssessment.new(subject_assessment_params)

    @subject_assessment.teacher_id = @teacher.id
    @subject_assessment.classroom_id = @classroom.id

    if @subject_assessment.save
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to teacher_url(@teacher)}
      end
    else
      render :new, status: :bad_request
    end
  end

  def destroy
    @teacher = Teacher.friendly.find(params[:teacher_id])
    @classroom = Classroom.find(params[:classroom_id])
    @subject_assessment = SubjectAssessment.find(params[:id])

    if @subject_assessment.delete
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to teacher_classroom_subject_assessments_path(@teacher, @classroom, @subject_assessment)}
      end
    end
  end

  private

  def subject_assessment_params
    params.require(:subject_assessment).permit(:subject, :knowledge, :presentation, :clear_explanation,
                                               :punctuality, :hygiene_and_personality, :akhlaq_and_behaviour,
                                               :communication_with_students, :remarks)
  end
end