require 'rubygems'
require 'face'

class FaceCheck

  API_KEY = '7f989de9de86be737acbdd6ce3ee07da'
  API_SECRET = 'cb8cd1072cd1bfeacbb1a9e8080321d2'

  def self.mapping(image_path)
    FaceCheck.new(image_path).mugijilize
  end

  def initialize(user)
    @user = user
  end

  def mugijilize
    #image = CvMat.load("./icon/original/#{@user}.jpg")

    #[DEFAULT_FACE_XML,FRONT_FACE_XML,FRONT_FACE2_XML,FRONT_FACE3_XML,HARF_FACE_XML, ANIME_FACE_XML].each { |xml|
    #  masked(xml, image)
    #}

    client = Face.get_client(:api_key => API_KEY, :api_secret => API_SECRET)
    data = client.faces_detect(:file => File.new("/tmp/#{@user}.jpg",'rb'))
    puts data
    if !data["photos"][0]["tags"].empty? 

      tags = data['photos'].first['tags'].first

      width = data['photos'].first['width'].to_f * 0.6
      height = data['photos'].first['height'].to_f * 0.6

      x = tags['center']['x'].to_f - (width / 10)
      y = tags['center']['y'].to_f - (height / 10)

      ["00","01","02","03","04","05"].each { |mask|
        Image.new(@user).overlay(x, y, width, height, mask)
      }
    end

    @user
  rescue => e
    puts e
    @user
  end

end

