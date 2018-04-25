# frozen_string_literal: true

require 'cuba'
require 'securerandom'
require 'net/http'
require 'json'

Cuba.define do
  on get do
    on '/script.js' do
      File.open('script.js', 'r') { |f| res.write f.read }
    end

    on '/style.css' do
      File.open('style.css', 'r') { |f| res.write f.read }
    end

    on 'jira', param('id') do |id|
      jira_request = Net::HTTP::Get.new('/')
      jira_request.body = body unless body.nil?
      request.basic_auth(ENV['JIRA_USERNAME'], ENV['JIRA_PASSWORD'])

      jira_conn             = Net::HTTP.new('https://jira.skintertainment.com')
      jira_conn.use_ssl     = 'TLSv1'
      jira_conn.verify_mode = OpenSSL::SSL::VERIFY_NONE

      jira_response = jira_conn.request(jira_request)
      json = JSON.parse(jira_response)
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
