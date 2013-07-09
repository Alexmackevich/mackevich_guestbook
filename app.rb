require 'sinatra'

get '/' do
	@posts = read_posts
	erb :index 
end

post '/' do 
	author = params[:author].strip.chomp
	content = params[:content].strip.chomp
	write_post(author, content)
  erb :index
end


def read_posts
	content = File.open("posts.txt") do |file|
		file.read
	end
	unparsed_posts = content.split("=====\n")
	text = /^date:\s(.+)\nauthor:\s(.+)\ncontent:\s(.+)$/
	posts ||= []

  unparsed_posts.each do |post|
    text =~ post.gsub(/\r\n/, '\n')

    parse_data = Regexp.last_match

    parsed_post = Hash.new
    parsed_post[:date] = parse_data[1].strip.chomp
    parsed_post[:author] = parse_data[2].strip.chomp
    parsed_post[:content] = parse_data[3].strip.chomp

    posts << parsed_post
end
end


def write_post (author, content)
	File.open('posts.txt', 'a') do |file|
		file.puts "date:#{Time.new}"
		file.puts "author:#{author}"
		file.puts "content:#{content}"
		file.puts "====="
	end
end

# def clear_posts
# 	File.open('posts.txt', 'w') do |file|
# 		file.puts ""
# 	end
