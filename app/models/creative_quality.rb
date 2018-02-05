class CreativeQuality < ApplicationRecord
  has_many :question_choices

  validates :name, :description, :color, presence: true

  def normalized_score
  	total_raw = 0
  	total_max = 0
	Response.all.each do |response|
	  	this_res = response.scores(self.name)
	  	
	  	total_raw += this_res[:raw]
	  	total_max += this_res[:max]
	end
	#binding.pry
	return ((total_raw.to_f / total_max.to_f) * 100).to_i
  end

end
