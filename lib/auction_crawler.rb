require "open-uri"
require "net/http"
require "json"
require_relative "auction_crawler/version"
require_relative "auction_crawler/auction_item"
require_relative "auction_crawler/info_runner"
require_relative "auction_crawler/auction"


module AuctionCrawler
  class Error < StandardError; end

end
