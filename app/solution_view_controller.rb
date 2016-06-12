class SolutionViewController < UIViewController
  TOP_PADDING = 100
  LEFT_PADDING = 100
  ENTITY_VIEW_HEIGHT = 36

  attr_accessor :image, :level, :gas

  def viewDidLoad
    setTitle('Solving')
    view.backgroundColor = UIColor.whiteColor

    bounds = [[0, TOP_PADDING], [app_frame.size.width, 20]]
    @loading_label = UILabel.alloc.initWithFrame(bounds)
    @loading_label.backgroundColor = UIColor.clearColor
    @loading_label.font = UIFont.systemFontOfSize(17.0)
    @loading_label.text = 'Attempting to solve...'
    @loading_label.textAlignment = UITextAlignmentCenter
    view.addSubview(@loading_label)

    data = UIImagePNGRepresentation(image)
    encoded_image = data.base64EncodedStringWithOptions(0)
    body = { image: encoded_image, level: level, gas: gas }

    AFMotion::JSON.post("http://localhost:9292/v1/detect.json", body) do |result|
      payload = BW::JSON.parse(result.body)

      if (result.status_code / 100) == 2
        @loading_label.hidden = true
        show_solution(payload['data']['solution'])
      else
        Messaging.show_error_message("Something went wrong: '#{result.first['error']}'")
      end
    end
  end

  private

  def show_solution(solution)
    y = TOP_PADDING

    solution.each do |entity|
      entity_view = EntityView.alloc.initWithFrame([[LEFT_PADDING, y], [app_frame.size.width - (LEFT_PADDING * 2), ENTITY_VIEW_HEIGHT]])
      entity_view.backgroundColor = UIColor.clearColor
      entity_view.entity = entity
      view.addSubview(entity_view)

      y += ENTITY_VIEW_HEIGHT
    end
  end

  def app_frame
    UIScreen.mainScreen.applicationFrame
  end
end
