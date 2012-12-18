# encoding: UTF-8

require 'spec_helper'

feature 'Home' do

  background do
    log_in_user
  end

  scenario 'Inicia sesión y visita el home', js: true do
    visit root_path
    page.should have_content 'tatooine'
  end

end
