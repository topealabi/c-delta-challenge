require 'rails_helper'

describe Response do
  context 'associations' do
    it { is_expected.to have_many(:question_responses) }
    it { is_expected.to have_many(:question_choices) }
    it { is_expected.to have_many(:creative_qualities) }

  end

  context 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end

  describe '#display_name' do
    let(:response) { Response.new(first_name: 'Tal', last_name: 'Safran') }

    it 'concatenates the first and last name' do
      expect(response.display_name).to eql('Tal Safran')
    end
  end

  describe '#completed?' do
    let(:response) { Response.new } 

    before do
      allow(Question).to receive(:count).and_return(3)
      allow(response).to receive_message_chain(:question_responses, :count)
        .and_return(response_count)
    end

    context 'when no responses exist' do
      let(:response_count) { 0 }
      it 'is false' do
        expect(response.completed?).to be(false)
      end
    end

    context 'when some responses exist' do
      let(:response_count) { 1 }
      it 'is false' do
        expect(response.completed?).to be(false)
      end
    end

    context 'when responses exist for all questions' do
      let(:response_count) { 3 }
      it 'is true' do
        expect(response.completed?).to be(true)
      end
    end
  end

  describe '#creative_scores' do
    let(:response) {Response.new}

    before do
      #
    end

    context 'when no responses exist' do
      let(:response_count) { 0 }
      it 'is empty' do
        expect(response.creative_scores).to eql([]) #empty array
      end
    end

    context 'when responses exist' do
      
      it 'returns the existing qualities' do
        

        response = Response.create( first_name: "Myers", last_name: "Briggs")
        question_choice = QuestionChoice.create(score: 3, text: "choice text")
        question = Question.create(title: "some randwom sentence", question_choices: [question_choice])
        creative_quality = CreativeQuality.create(name: "samle", description: "desc", color: "color", question_choices: [question_choice])
        question_response = QuestionResponse.create(response_id: response.id, question_choice_id: question_choice.id)

        expect(response.creative_scores.length).to eql(1)
        expect(response.creative_scores.first[:raw]).to eq(question_choice.score)
        expect(response.creative_scores.first[:max]).to eq(question_choice.score)
        ##
      end
    end

  end
end
