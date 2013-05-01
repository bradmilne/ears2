require 'spec_helper'

describe Question do
  before :each do
  	@question = FactoryGirl.create(:question)
  end

  it 'should be an instance of Quiz' do
  	@question.should be_an_instance_of Question
  end

end
