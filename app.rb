require 'sinatra'




get '/' do
  @posts = read_posts
  erb :index
end

get '/clear' do
  clear_file

  redirect to('/')
end

post '/' do
  author = params[:author]
  content = params[:content]
  if author.empty? != true && content.empty? != true
    write_post author, content
end

erb :index
redirect to('/')
end



def read_posts
  file_content = File.open("posts.txt") do |file|
    file.read
  end

  rows = file_content.split("=====\n").map{ |row| row.chomp }

  paragraphs = rows.collect do |row|
    if /^date: (?<date>.*)\nname: (?<name>.*)\ncontent: (?<content>.*)$/m =~ row
      { date:date, name: name, content: content }
    end
  end

  line = ""
  paragraphs.each do |paragraph|
    line << "<p>Date: #{paragraph[:date]}<br> Name: #{paragraph[:name]}<br> 
                                  Post: #{paragraph[:content]}<br></br> "
  
  end 
    line
end


def write_post (author, content)
  File.open('posts.txt', 'a') do |file|
    file.puts "date: #{Time.new}"
    file.puts "name: #{author}"
    file.puts "content: #{content}"
    file.puts "====="
  end
end

def clear_file
  File.open('posts.txt', 'w') do |file| 
    file.print ''
  end
end