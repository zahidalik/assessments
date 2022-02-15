module ClassroomsHelper
  def knowledge_percentage(classroom)
    (classroom.subject_assessments.sum(:knowledge) / (classroom.subject_assessments.count * 5).to_f * 100).round(1)
  end
  
  def presentation_percentage(classroom)
    ((classroom.subject_assessments.sum(:presentation) / (classroom.subject_assessments.count * 5).to_f) * 100).round(1)
  end

  def clear_explanation_percentage(classroom)
    ((classroom.subject_assessments.sum(:clear_explanation) / (classroom.subject_assessments.count * 5).to_f) * 100).round(1)
  end

  def punctuality_percentage(classroom)
    ((classroom.subject_assessments.sum(:punctuality) / (classroom.subject_assessments.count * 5).to_f) * 100).round(1)
  end

  def hygiene_and_personality_percentage(classroom)
    ((classroom.subject_assessments.sum(:hygiene_and_personality) / (classroom.subject_assessments.count * 5).to_f) * 100).round(1)
  end

  def akhlaq_and_behaviour_percentage(classroom)
    ((classroom.subject_assessments.sum(:akhlaq_and_behaviour) / (classroom.subject_assessments.count * 5).to_f) * 100).round(1)
  end

  def communication_with_students_percentage(classroom)
    ((classroom.subject_assessments.sum(:communication_with_students)/ (classroom.subject_assessments.count * 5).to_f) * 100).round(1)
  end

  def categorise(int)
    case int
    when 5
      "Excellent"
    when 4
      "Very Good"
    when 3
      "Good"
    when 2
      "Satisfactory"
    when 1
      "Poor"
    else
      "Can't define"
    end
  end
end