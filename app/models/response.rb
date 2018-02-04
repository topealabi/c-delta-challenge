class Response < ApplicationRecord
  has_many :question_responses
  has_many :question_choices, through: :question_responses
  has_many :creative_qualities, through: :question_choices

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :count, to: :question_responses, prefix: true

  def display_name
    "#{first_name} #{last_name}"
  end

  def completed?
    question_responses_count == Question.count
  end

  def creative_scores
    qualities_array = []
    scores_array =[]

    self.creative_qualities.each do |cq|
      qualities_array.push(cq.name)
    end

    qualities_array.uniq!
    qualities_array.each do |quality_name|
      raw_score = 0
      max_score = 0
      self.question_choices.where(creative_quality_id: CreativeQuality.find_by_name(quality_name)).each do |question_choice|
        
        raw_score += question_choice.score
      end

      self.question_choices.where(creative_quality_id: CreativeQuality.find_by_name(quality_name)).each do |question_choice|
        temp_max = []
        question_choice.question.question_choices.each do |question_choice|
          temp_max.push(question_choice.score)
        end
        max_score += temp_max.max
      end

      scores_array.push({name: quality_name, raw: raw_score, max: max_score})
    end
    return scores_array
  end
end
