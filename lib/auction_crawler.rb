require "auction_crawler/version"
require "auction_crawler/auction_item"
require "auction_crawler/info_runner"
require "open-uri"
require "net/http"
require "json"

module AuctionCrawler
  class Error < StandardError; end

end
