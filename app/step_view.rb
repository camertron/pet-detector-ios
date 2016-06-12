class StepView < UIView
  attr_accessor :number, :header, :body

  def drawRect(rect)
    number_dim = 29
    bounds = [[0, 0], [number_dim, number_dim]]
    @number_image = UIImageView.alloc.initWithFrame(bounds)
    @number_image.setImage(UIImage.imageNamed("steps/#{number}.png"))
    addSubview(@number_image)

    number_right = number_dim + 10
    label_width = rect.size.width - number_dim - 10

    bounds = [[number_right, 0], [label_width, 20]]
    @header_label = UILabel.alloc.initWithFrame(bounds)
    @header_label.backgroundColor = UIColor.clearColor
    @header_label.font = UIFont.systemFontOfSize(17.0)
    @header_label.text = header
    @header_label.sizeToFit
    addSubview(@header_label)

    if has_body?
      bounds = [[number_right, 23], [label_width, 40]]
      @body_label = UILabel.alloc.initWithFrame(bounds)
      @body_label.lineBreakMode = UILineBreakModeWordWrap
      @body_label.numberOfLines = 0
      @body_label.backgroundColor = UIColor.clearColor
      @body_label.font = UIFont.systemFontOfSize(12.0)
      @body_label.textColor = gray
      @body_label.text = body
      @body_label.sizeToFit
      addSubview(@body_label)
    end
  end

  def has_body?
    body && !body.strip.empty?
  end

  def gray
    @gray ||= UIColor.colorWithRed(
      87.0 / 255, green: 87.0 / 255, blue: 87.0 / 255, alpha: 1.0
    )
  end

  def border_gray
    @border_gray ||= UIColor.colorWithRed(
      215.0 / 255, green: 215.0 / 255, blue: 215.0 / 255, alpha: 1.0
    )
  end

  def app_frame
    UIScreen.mainScreen.applicationFrame
  end
end
