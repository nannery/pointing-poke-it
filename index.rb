# frozen_string_literal: true

require 'cuba'
require 'securerandom'

Cuba.define do
  on get do
    on ':id' do |_id|
      # res.write 'hi bro'
      # render 'index.html'
      File.open('index.html', 'r') do |file|
        res.write file.read
      end
    end

    on root do
      id = SecureRandom.hex 4
      res.redirect '/' + id
    end
  end
end
