class EntityView < UIView
  LEFT_PADDING = 40

  attr_accessor :entity

  def drawRect(rect)
    super

    @image = UIImageView.alloc.initWithImage(UIImage.imageNamed("entities/#{entity}.png"))
    @image.contentMode = UIViewContentModeScaleAspectFit
    addSubview(@image)

    bounds = [[40, 11], [0, 0]]
    @label = UILabel.alloc.initWithFrame(bounds)
    @label.backgroundColor = UIColor.clearColor
    @label.font = UIFont.systemFontOfSize(15.0)
    @label.text = "#{entity_type} #{entity_name}"
    @label.sizeToFit
    addSubview(@label)
  end

  def entity_type
    capitalize(entity.split(/(pet|house)/)[1])
  end

  def entity_name
    capitalize(entity.split(/(pet|house)/)[2])
  end

  private

  def capitalize(str)
    str.sub(/\A(.)/) { $1.upcase }
  end
end
