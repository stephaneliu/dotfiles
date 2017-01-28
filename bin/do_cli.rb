#!/usr/bin/env ruby
require 'barge'
require 'delegate'

class DigitalOcean
  attr_reader :client, :droplets, :sizes

  def initialize
    @client = Barge::Client.new(access_token: ENV['DO_KEY'])
  end

  def droplets
    @_droplets ||= client.droplet.all[:droplets].map { |drop| DropletDecorator.new(drop) }
  end

  def list_droplets
    puts droplets
  end

  def list_sizes
    puts sizes
  end

  def sizes
    @_sizes ||= client.size.all.sizes.map { |size| SizeDecorator.new(size) }
  end

  def list_regions
    puts regions
  end

  def regions
    @_regions ||= client.region.all.regions.map {|region| RegionDecorator.new(region) }
  end

  def list_images
    puts images
  end

  def images
    @_images ||= client.image.all.images.map { |image| ImageDecorator.new(image) }
  end

  def list_ssh_keys
    puts ssh_keys
  end

  def ssh_keys
    @_keys ||= client.key.all.ssh_keys.map {|key| SshKeyDecorator.new(key) }
  end

  def create
    preload

    options = {}

    ask "Name of droplet" do |answer|
      options[:name] = answer
      "continue"
    end

    ask "Region of droplet (region / list)" do |answer|
      region = ""

      if answer == "list"
        list_regions
        region = ""
      elsif !regions.map(&:slug).include? answer
        puts "Region #{answer} not found. Try 'list'"
        region = ""
      else
        region = answer
        options[:region] = region
      end

      region
    end

    ask "What size instance? (1-#{sizes.size} / list)" do |answer|
      size = ""

      case answer
      when "list"
        sizes.each_with_index do |size, index|
          puts "#{index + 1} - #{size.slug}"
        end
        size = ""
      when "1".."#{sizes.size - 1}"
        size = sizes.map(&:slug)[Integer(answer) - 1]
        options[:size] = size
      else
        puts "Size unexpected: #{answer}"
        size = ""
      end
    end

    ask "Image name? (1-#{images.size}, list)" do |answer|
      image = ""

      case answer
      when "list"
        images.each_with_index do |image, index|
          puts "#{index + 1} - #{image}"
        end
      when "0".."#{images.size}"
        image = images.map(&:slug)[Integer(answer) - 1]
        options[:image] = image
      else
        puts "Image unexpected: #{answer}"
        image = ""
      end

      image
    end

    ask "ssh key id (ssh key id / list)" do |answer|
      selected_ssh_keys = []

      if answer == "list"
        list_ssh_keys
      elsif !ssh_keys.map(&:id).include? Integer(answer)
        puts "ssh key id not found. Try 'list'"
      else
        selected_ssh_keys << Integer(answer)
        options[:ssh_keys] = selected_ssh_keys
      end
      selected_ssh_keys
    end

    ask "Enable backup? (yes / no)" do |answer|
      enable_backup = false

      if answer.downcase == 'yes'
        enable_backup = true
      end

      options[:backups] = enable_backup
      "continue"
    end

    ask "Enable ipv6? (yes / no)" do |answer|
      enable_ipv6 = false

      if answer.downcase == 'yes'
        enable_ipv6 = true
      end

      options[:ipv6] = enable_ipv6
      "continue"
    end

    puts options
    confirm "Create a new image? (YES / [NO])", "YES" do
      puts "Image being created"
      puts client.droplet.create(options).success?
    end
  end

  def destroy
    droplet_id = ""
    ask "What is the ID of the droplet? (droplet_id / list)" do |answer|
      if answer.downcase == "list"
        list_droplets
      else
        droplet_id  = answer
      end

      droplet_id
    end

    confirm "Are you sure you want to delete: #{droplet_id}? (YES / [NO])", "YES" do
      if client.droplet.destroy(droplet_id)
        puts "Droplet #{droplet_id} destroyed"
      end
    end
  end

  # TODO - Implement 'ask' format
  def snapshot(droplet_id, snapshot_name)
    client.droplet.snapshot(droplet_id, name: snapshot_name)
  end

  private

  def preload
    print 'Hang on while I connect to Digital Ocean...'
    [:regions, :sizes, :images, :ssh_keys].each do |preload|
      public_send(preload)
      print '...'
    end
    puts ''
  end

  def ask(question)
    answer = ""
    while answer.empty? do
      puts question
      answer = $stdin.gets.chomp!

      if quit?(answer)
        exit 
      else
        answer = yield answer
      end
    end
  end

  def confirm(question, confirmation)
    puts question
    yield if $stdin.gets.chomp! == confirmation
  end

  def quit?(response)
    response.downcase == 'exit' || response.downcase == 'q'
  end

  def find_droplet(droplet_id)
    droplet = nil

    catch(:done) do
      droplets.each do |drop|
        if drop.id == droplet_id
          droplet = drop
          throw :done
        end
      end
    end

    droplet
  end

end

class DropletNotFoundError < StandardError; end

class SizeDecorator < SimpleDelegator
  
  def to_s
    <<-eos
Memory: #{slug.capitalize}
Disk:  #{disk}GB
Transfers: #{transfer}Gib
Price / Month: $#{price_monthly}
Price / Hour: $#{price_hourly}
Available Regions #{regions}

    eos
  end
end

class DropletDecorator < SimpleDelegator
  attr_reader :definition, :droplets

  def to_s
    <<-eos
ID: #{id}
Name: #{name}
Region: #{region.name} / #{region.slug}
OS: #{kernel.name} - #{kernel.version}
Memory Size: #{memory}
Disk Size: #{disk}

    eos
  end

end

class RegionDecorator < SimpleDelegator
  attr_reader :definition

  def to_s
    "#{slug} (#{name})"
  end
end

class ImageDecorator < SimpleDelegator
  def to_s
    "#{slug} (#{name})"
  end
end

class SshKeyDecorator < SimpleDelegator
  def to_s
    <<-eos
#{id} - (#{name}): #{public_key}

    eos
  end
end

digital_ocean = DigitalOcean.new

available_actions  = %w(create destroy)
available_lists = %w(droplets images regions sizes ssh_keys)


# TODO - REPL command interface
action, context= ARGV

if action == "list" && available_lists.include?(context)
  digital_ocean.send("#{action}_#{context}")
elsif available_actions.include? action
  digital_ocean.send(action)
else
  puts "Request not recognized. Try one of these:"
  puts available_lists.map {|list| "list #{list}"}
  puts "or #{available_actions}"
end
