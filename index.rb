# frozen_string_literal: true

require 'cuba'
require 'securerandom'

Cuba.define do
  on get do
    on '/script.js' do
      File.open('script.js', 'r') { |f| res.write f.read }
    end

    on '/style.css' do
      File.open('style.css', 'r') { |f| res.write f.read }
    end

    on ':id' do |_id|
      File.open('index.html', 'r') { |f| res.write f.read }
    end

    on root do
      id = SecureRandom.hex 4
      res.redirect '/' + id
    end
  end
end
