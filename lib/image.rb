require 'rubygems'
require 'RMagick'

class Image

  def initialize(user)
    @user = user
  end

  def overlay(x,y,width,height, mask)
    image = Magick::Image.read("/tmp/#{@user}.jpg").first
    image.composite!(mask(width,height,mask), x-5, y-5, Magick::OverCompositeOp)
    image.resize!(64,64)
    image.write("/tmp/#{@user}_#{mask}.png")
  end

  private
  def mask(width,height,mask)
    image = Magick::Image.read("./lib/image/#{mask}.png").first
    image.resize!(width*1.3,height*1.3)
    image
  end
end

