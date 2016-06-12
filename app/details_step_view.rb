class DetailsStepView < StepView
  FIELD_WIDTH = 80
  FIELD_HEIGHT = 35

  def drawRect(rect)
    super

    bottom_ctl = has_body? ? @body_label : @header_label
    x = bottom_ctl.frame.origin.x
    y = bottom_ctl.frame.origin.y + bottom_ctl.size.height + 10
    @level_label = create_label(x, y, 'Level')
    addSubview(@level_label)
    @level_field = create_field(x, y + @level_label.size.height + 5)
    @level_field.text = '12'
    addSubview(@level_field)

    x = x + @level_field.size.width + 10
    @gas_label = create_label(x, y, 'Gas')
    addSubview(@gas_label)
    @gas_field = create_field(x, y + @gas_label.size.height + 5)
    @gas_field.text = '21'
    addSubview(@gas_field)
  end

  def level
    @level_field.text.strip.empty? ? nil : @level_field.text.to_i
  end

  def gas
    @gas_field.text.strip.empty? ? nil : @gas_field.text.to_i
  end

  private

  def create_label(x, y, text)
    bounds = [[x, y], [0, 0]]
    label = UILabel.alloc.initWithFrame(bounds)
    label.backgroundColor = UIColor.clearColor
    label.font = UIFont.systemFontOfSize(12.0)
    label.text = text
    label.textColor = gray
    label.sizeToFit
    label
  end

  def create_field(x, y)
    bounds = [[x, y], [FIELD_WIDTH, FIELD_HEIGHT]]

    field = UITextField.alloc.initWithFrame(bounds)
    field.borderStyle = UITextBorderStyleRoundedRect
    field.clearButtonMode = UITextFieldViewModeWhileEditing
    field.returnKeyType = UIReturnKeyDone
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
    field.autocapitalizationType = UITextAutocapitalizationTypeNone
    field.keyboardType = UIKeyboardTypeDecimalPad

    spacer = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target: nil, action: nil)
    bar_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target: field, action: 'resignFirstResponder')
    toolbar = UIToolbar.alloc.initWithFrame([[0, 0], [app_frame.size.width, 44]])
    toolbar.items = [spacer, bar_button]
    field.inputAccessoryView = toolbar

    field
  end
end
