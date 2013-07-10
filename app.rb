require 'sinatra'

get '/' do
	erb :index
end

post '/' do 
	author = params[:author].strip.chomp
	content = params[:content].strip.chomp
	write_post(author, content)
  erb :index
end


def read_posts
	file_content = File.open("posts.txt") do |file|
		file.read
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
