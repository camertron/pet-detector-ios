class ChooseImageStepView < StepView
  attr_accessor :button_text, :on_button_click

  def drawRect(rect)
    super

    bottom_label = has_body? ? @body_label : @header_label
    x = bottom_label.frame.origin.x
    y = bottom_label.frame.origin.y + bottom_label.size.height + 10
    bounds = [[x, y], [100, 25]]
    @button = UIButton.buttonWithType(UIButtonTypeSystem)
    @button.frame = bounds
    @button.layer.masksToBounds = true
    @button.layer.cornerRadius = 3
    @button.layer.borderWidth = 1
    @button.layer.borderColor = border_gray.CGColor
    @button.setTitle(button_text, forState:UIControlStateNormal)
    @button.setTitle(button_text, forState:UIControlStateSelected)
    @button.addTarget(self, action:'on_click', forControlEvents:UIControlEventTouchUpInside)
    addSubview(@button)

    check_dim = 16
    x = @button.frame.origin.x + @button.size.width + 7
    y = @button.frame.origin.y + 4
    bounds = [[x, y], [check_dim, check_dim]]
    @check_image = UIImageView.alloc.initWithFrame(bounds)
    @check_image.setImage(UIImage.imageNamed('steps/checkmark.png'))
    @check_image.hidden = true
    addSubview(@check_image)
  end

  def show_check
    @check_image.hidden = false
  end

  def hide_check
    @check_image.hidden = true
  end

  private

  def on_click
    on_button_click.call
  end
end
