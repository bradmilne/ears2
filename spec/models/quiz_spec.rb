require 'spec_helper'

describe Quiz do
  
  before :each do
  	@quiz = FactoryGirl.create(:quiz)
  end

  it 'should be an instance of Question' do
  	@quiz.should be_an_instance_of Quiz
  end
end
