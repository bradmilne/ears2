require 'spec_helper'

describe Lesson do

  before :each do
  	@lesson = FactoryGirl.create(:lesson)
  end

  it 'should be an instance of Lesson' do
  	@lesson.should be_an_instance_of Lesson
  end


  describe 'title' do

    it 'should have a title created' do
      @lesson.title.should == "Sample Lesson"
    end

    it 'should have a title thats a string' do
      @lesson.title.should be_a(String)
    end

  end

  describe 'description' do

    it 'should have a description created' do
      @lesson.description.should == "A sample lesson for everyone that wants to learn"
    end

    it 'should have a description thats a string' do
      @lesson.description.should be_a(String)
    end
  end

  describe 'category' do

    it 'should have a category created' do
      @lesson.category.should == "Ear Training"
    end

    it 'should have a category thats a string' do
      @lesson.category.should be_a(String)
    end
  end

end
