class StartViewController < UIViewController
  LEFT_PADDING = 40
  TOP_PADDING = 100

  attr_reader :image, :level, :gas

  def viewDidLoad
    setTitle('Pet Detector')
    view.backgroundColor = UIColor.whiteColor

    @next_button = UIBarButtonItem.alloc.initWithTitle('Solve', style: UIBarButtonItemStylePlain, target: self, action: 'on_solve_click')
    navigationItem.rightBarButtonItem = @next_button

    setup_screenshot_view
    setup_choose_image_view
    setup_details_view
  end

  def validate
    errors = []

    if image.nil?
      errors << 'Please select a screenshot.'
    end

    if level.nil?
      errors << 'Please tell us the Pet Detective level in the screenshot.'
    elsif level <= 0
      errors << 'Invalid level.'
    end

    if gas.nil?
      errors << 'Please tell us how much gas is available in the screenshot.'
    elsif gas <= 0
      errors << 'Invalid amount of gas.'
    end

    errors
  end

  def level
    @details_view.level
  end

  def gas
    @details_view.gas
  end

  private

  def on_solve_click
    errors = validate

    if errors.size > 0
      Messaging.show_error_message(errors.first)
      return
    end

    solution_controller = SolutionViewController.alloc.init
    solution_controller.image = image
    solution_controller.level = level
    solution_controller.gas = gas
    navigationController.pushViewController(solution_controller, animated: true)
  end

  def setup_screenshot_view
    width = app_frame.size.width - (LEFT_PADDING * 2)
    bounds = [[LEFT_PADDING, TOP_PADDING], [width, 65]]
    @screenshot_view = StepView.alloc.initWithFrame(bounds)
    @screenshot_view.backgroundColor = UIColor.clearColor
    @screenshot_view.number = 1
    @screenshot_view.header = 'Take a Screenshot.'
    @screenshot_view.body = 'While in the game, press the home button then the power button.'
    view.addSubview(@screenshot_view)
  end

  def setup_choose_image_view
    width = app_frame.size.width - (LEFT_PADDING * 2)
    bounds = [[LEFT_PADDING, @screenshot_view.frame.origin.y + @screenshot_view.size.height + 10], [width, 80]]
    @choose_image_view = ChooseImageStepView.alloc.initWithFrame(bounds)
    @choose_image_view.backgroundColor = UIColor.clearColor
    @choose_image_view.button_text = 'Select'
    @choose_image_view.on_button_click = method(:on_select_image_click)
    @choose_image_view.number = 2
    @choose_image_view.header = 'Select a screenshot.'
    @choose_image_view.body = 'Choose which game screenshot to solve.'
    view.addSubview(@choose_image_view)
  end

  def setup_details_view
    width = app_frame.size.width - (LEFT_PADDING * 2)
    bounds = [[LEFT_PADDING, @choose_image_view.frame.origin.y + @choose_image_view.size.height + 10], [width, 65]]
    @details_view = DetailsStepView.alloc.initWithFrame(bounds)
    @details_view.backgroundColor = UIColor.clearColor
    @details_view.number = 3
    @details_view.header = 'Fill in a few details.'

    view.addSubview(@details_view)
  end

  def on_select_image_click
    BW::Device.camera.any.picture(media_types: [:image]) do |result|
      if result[:original_image]
        @image = result[:original_image]
        @choose_image_view.show_check
      end
    end
  end

  def app_frame
    UIScreen.mainScreen.applicationFrame
  end
end
