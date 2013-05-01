require 'spec_helper'

describe Response do
  
  before :each do
  	@response = FactoryGirl.create(:response)
  end

  it 'should be an instance of Question' do
  	@response.should be_an_instance_of Response
  end
end
