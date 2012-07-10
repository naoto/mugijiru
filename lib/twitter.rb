require 'open-uri'

class Twitter

  def self.get_icon(user)
    twitter = Twitter.new(user)
    twitter.icon
  end

  def initialize(user)
    @user = user
  end 

  def icon
    url = "http://api.twitter.com/1/users/profile_image/#{@user}.json?size=original"
   
    file_puts("/tmp/#{@user}.jpg") do |file|
      file_get(url) do |d|
        file.write d.read
      end
    end
  end


  private
  def file_get(url)
    open(URI.escape(url)) do |d|
      yield d
    end
  end

  def file_puts(path)
    open(path, 'wb') do |d|
      yield d
    end
  end

end
