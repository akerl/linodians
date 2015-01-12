require 'open-uri'
require 'nokogiri'

##
# Module for parsing Linode employee info
module Linodians
  DATA_URL = 'https://www.linode.com/employees'

  class << self
    ##
    # Insert a helper .new() method for creating a new Group object
    def new(*args)
      self::Group.new(*args)
    end

    def download_data
      Nokogiri::HTML(open(DATA_URL)).css('.employee-display').map do |block|
        data = parse_user(block).merge parse_social(block)
        Employee.new data
      end
    end

    private

    def parse_user(block)
      {
        username: block.at_css('img')['img-name'],
        fullname: block.at_css('strong').text,
        title: block.at_css('small').text
      }
    end

    def parse_social(block)
      block.css('a.employee-link').map do |link|
        # Social site name from CSS class, link target
        [link[:class].split.last.split('-').last.to_sym, link['href']]
      end.to_h
    end
  end
end

require 'linodians/employee'
require 'linodians/group'
