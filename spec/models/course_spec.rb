# encoding: utf-8

require 'spec_helper'

describe Course do
  
  let(:course) {
    Course.create name: "Curso", description: "description"
  }
  
  let(:level) {
    Level.create name: "básico"
  }
  
  it 'should give me all the basic courses' do
    course.level = level
    course.save
    
    Course.with_level("básico").count.should be(1)
  end
end