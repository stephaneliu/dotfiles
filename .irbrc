def help
  puts "Setup:"
  puts "  gem install awesome_print"
  puts "   gem install wirble"
  puts "   gem install looksee"
  puts " "
  puts "Utilities:" 
  puts "  Wirble - provides tab completion, saved histories, and misc irb extensions"
  puts " "
  puts "Shortcuts:"
  puts "  clear         - shortcut for system 'clear'"
  puts "  ls            - User.first.ls or User.ls - prints lookup path info"
  puts "  p User.first  - prints object in hash format using pretty awesome print"
  puts "  pm            - User.pm - prints methods of an object"
  puts "  r             - shortcut for reload! Does not reload changes to this file"
  puts "  route         - route.recognize_path(options) or route.generate_path(options)"
  puts "  show(User)    - prints columns of an ActiveRecord object "
  puts "  show_regex    - show_regex('hello', /el/) - from pickaxe book"
end

%w|rubygems ap pp wirble looksee|.each do |lib|
  begin
    require lib
  rescue LoadError => err
    warn "Couldn't load an irb gem: #{err}"
  end
end

Wirble.init
Wirble.colorize

# irb indent options
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200

# Method to clear rails console like bash
def clear; system 'clear'; end
# map to awesome_print - hash format of attributes
def p(arg); ap(arg); nil; end
def r; reload!; end

# annotate column names of an AR model
def show(obj)
  y(obj.send("column_names"))
end

# route.recognize_path '/users/1', :method => :get
# route.generate :controller => 'events', :action => 'edit', :id => 1
# Pass true to reload of changes have been made to route.rb while in active script console
def route(reload=false)
  load "config/routes.rb" if reload
  Rails.application.routes
end

# for rails 3
if defined?(Rails) && !Rails.env.nil?
  ActiveRecord::Base.logger = Logger.new(STDOUT) if Rails.logger
  # You are using RSpec, RIGHT?????
  require 'spec/spec_helper' if Rails.env == 'test'

  # Display the RAILS ENV in the prompt - [Development]>> 
  IRB.conf[:PROMPT][:CUSTOM] = {
    :PROMPT_N => "[#{Rails.env.capitalize}]>> ",
    :PROMPT_I => "[#{Rails.env.capitalize}]>> ",
    :PROMPT_S => nil,
    :PROMPT_C => "?> ",
    :RETURN => "=> %s\n"
  }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

def route_usage
  puts "usage: \n route.recognize_path '/watch/events/1', :method => :get \n route.generate :controller => 'event', :action => 'index'"
  puts "or use app.url_for(:controller => ...) or app.new_user_path"
end

# From Pickaxe
def show_regex(a, re)
  # $& - assigned to match
  # $^ - last matched
  # $+ - last matched group
  # $` - assigned to part preceeding match
  # $' - assigned to part after match
  a =~ re ? "#{$`}<<#{$&}>>#{$'}" : "no match"
end

# Method to pretty-print object methods
# Coded by sebastian delmont
# http://snippets.dzone.com/posts/show/2916
class Object
  ANSI_BOLD = "\033[1m"
  ANSI_RESET = "\033[0m"
  ANSI_LGRAY = "\033[0;37m"
  ANSI_GRAY = "\033[1;30m"
 
  # Print object's methods
  # Usage: User.first.pm
  def pm(*options)
    methods = self.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter
 
    data = methods.sort.collect do |name|
      method = self.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI_BOLD}#{item[0].to_s.rjust(max_name)}#{ANSI_RESET}"
      print "#{ANSI_GRAY}#{item[1].to_s.ljust(max_args)}#{ANSI_RESET}"
      print " #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
    end
    data.size
  end
end
