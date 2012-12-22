# encoding: utf-8

require 'spec_helper'

describe User do

  let(:user) { User.new }

  it "should have a valid name" do
    user.first_name = "email@domain.com"
    user.name.should eql "email"
  end

  it "should have a complete name" do
    user.first_name = "Steven"
    user.last_name = "Jobs"
    user.complete_name.should eql "Steven Jobs"
  end

  it "should clean email addresses" do
    user.email = "account@youdontwanttoseethis.com"
    user.strip_email(user.email).should eql "account"
  end

  it "should have a default average level" do
    user.average_level.should eql "Básico"
  end  
end
