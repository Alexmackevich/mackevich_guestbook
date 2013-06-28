require 'sinatra'

get '/' do
	@posts = read_posts
	erb :index 
end

post '/' do 
	author = params[:author].strip
	content = params[:content].strip
	write_post(author, content)
  erb :index
end



def read_posts
	content = File.open("posts.txt") do |file|
		file.read
	end
	content.split("=====\n")
end


def write_post (author, content)
	File.open('posts.txt', 'a') do |file|
		file.puts "date:#{Time.new}"
		file.puts "author:#{author}"
		file.puts "content:#{content}"
		file.puts "====="
	end
end