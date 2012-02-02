require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'
require 'erb'
$:.unshift Dir.pwd
require 'node.rb'
require 'field.rb'

class MyApp < Sinatra::Base

  post '/' do
    size = params[:size].nil? ? '8,8'.split(',') : params[:size].split(',')
    source = params[:source].nil? ? '0,3'.split(',') : params[:source].split(',')
    target = params[:target].nil? ? '5,4'.split(',') : params[:target].split(',')
    algo = params[:algo].nil? ? 'breadth_first' : params[:algo]
  
	  @board = Field.createboard(size[0].to_i,size[1].to_i)
	
	  start = Field.new source[0].to_i,source[1].to_i
	  target = Field.new target[0].to_i,target[1].to_i
	
	  @s = start
	  @t = target
	  start_time = Time.now
	
    case algo
	    when 'breadth_first' then @result = start.breadth_first target
	    when 'breadth_first_minimal_cost' then @result = start.breadth_first_minimal_cost target
	    when 'depth_first' then @result = start.depth_first target
	    when 'depth_first_limit' then @result = start.depth_first_limit target
	    when 'hillclimbing' then @result = start.hillclimbing target 
	    when 'a_algo' then @result = start.a_algo target
	    else @result = start.breadth_first target
	  end
	  @foo = @result.path[@result.path.size-1].path_cost.to_s
	  finish_time = Time.new
	  @time = (finish_time - start_time).to_s
	  erb :index
  end
  
  get '/' do
    size = params[:size].nil? ? '8,8'.split(',') : params[:size].split(',')
    source = params[:source].nil? ? '0,3'.split(',') : params[:source].split(',')
    target = params[:target].nil? ? '5,4'.split(',') : params[:target].split(',')
    
	  @foo = "Algo"
	  @board = Field.createboard(size[0].to_i,size[1].to_i)
	
	  start = Field.new source[0].to_i,source[1].to_i
	  target = Field.new target[0].to_i,target[1].to_i
	
	  @s = start
	  @t = target
	  start_time = Time.now
	
	  @result = start.hillclimbing(target).path
	
	  finish_time = Time.new
	  @time = (finish_time - start_time).to_s

	  erb :index
  end

end

MyApp.run!
