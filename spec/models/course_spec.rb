# encoding: utf-8
require 'spec_helper'

describe Course do
  
  let(:course) {
    Course.create name: "Curso", description: "description", available_at: Date.today, can_be_published: true
  }
  
  let(:unpublished_course) {
    Course.create name: "Curso", description: "description", available_at: Date.today, can_be_published: false
  }
  
  let(:yet_unpublished_course) {
    Course.create name: "Curso", description: "description", available_at: Date.tomorrow, can_be_published: false
  }
  
  let(:level) {
    Level.create name: "básico"
  }
  
  it 'should give me all the basic courses' do
    course.level = level
    course.save
    
    Course.with_level("básico").count.should be(1)
  end
  
  it 'should give me all the available courses' do
    course.save
    Course.availables.count.should be(1)
  end
  
  it 'should give me 0 available courses because it is unpublished' do
    unpublished_course.save
    Course.availables.count.should be(0)
  end
  
  it 'should give me 0 available courses because it is unpublished' do
    yet_unpublished_course.save
    Course.availables.count.should be(0)
  end
end