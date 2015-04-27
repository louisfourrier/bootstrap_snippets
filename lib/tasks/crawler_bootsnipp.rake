
task :bootsnipp_crawler => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'net/http'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://bootsnipp.com/"
  
  # Here the number of pages in compute manually. Script if you want to detect it automatically.
  nb_array = (1..61).to_a.reverse
  ## ALL the pagination
  nb_array.each do |page_number|
    puts page_number.to_s
    
    # MAke the request with parameters page.
    uri = URI('http://bootsnipp.com/')
    params = { :page => page_number }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    
    # Treat the body html to create aliment by URL
    main_page = Nokogiri::HTML(res.body)
    page_snippets = main_page.css('.container > .row > .col-lg-4 > .thumbnail')
    puts page_snippets.count.to_s
    page_snippets.each do |l|
      a = l.css('.snipp-title a').first
      #puts a.to_s
      url = a['href'].to_s
      title = a.text.to_s
      
      img = l.css('img').first
      img_url = img['data-original'].to_s
      #puts img_url.to_s
      puts title.to_s
      #puts url.to_s
      Snippet.create(:title => title, :original_url => url, :image_url => img_url, :is_scraped  => true, :approved => true)
      
    end
  end
  
end




# Hellocoton crawler.Mode
task :snippet_scrapper_download => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  
  Snippet.find_each do |snippet|
      #puts snippet.title.to_s
      puts "Crawling of " + snippet.original_url.to_s
      href = snippet.original_url.to_s
      page = Nokogiri::HTML(open(href))
      url = href.to_s
      html_content = page.to_html.encode!('UTF-8', :undef => :replace, :invalid => :replace, :replace => "") 
      snippet.update(:html_content => html_content)
  end
  
end

# Hellocoton crawler.Mode
task :snippet_iframes_download => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  
  Snippet.find_each do |snippet|
      #puts snippet.title.to_s
      puts "Crawling of " + snippet.original_url.to_s
      href = snippet.iframe_url_original.to_s
      page = Nokogiri::HTML(open(href))
      url = href.to_s
      html_content = page.to_html.encode!('UTF-8', :undef => :replace, :invalid => :replace, :replace => "") 
      snippet.update(:iframe_html_content => html_content)
  end
  
end



