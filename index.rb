# frozen_string_literal: true

require 'cuba'
require 'securerandom'
require 'json'
require 'httparty'
require 'nokogiri'

Cuba.define do
  on get do
    on 'script.js' do
      File.open('script.js', 'r') { |f| res.write f.read }
    end

    on 'style.css' do
      File.open('style.css', 'r') { |f| res.write f.read }
    end

    on 'jira', param('id') do |id|
      jira_request = HTTParty.get(
        "#{ENV['JIRA_URL']}/browse/#{id}",
        basic_auth: {
          username: ENV['JIRA_USERNAME'],
          password: ENV['JIRA_PASSWORD']
        }
      )
      jira_request.ok? or return res.write("JIRA request failed for #{id}")

      parsed = Nokogiri::HTML(jira_request.body)
      node   = parsed.css('#summary-val')

      res.write(node.any? ? node.text : "Can't find title for #{id}")
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
