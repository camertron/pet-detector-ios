class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = StartViewController.alloc.init
    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    # BW::Device.camera.any.picture(media_types: [:image]) do |result|
    #   data = UIImagePNGRepresentation(result[:original_image])
    #   encoded_image = data.base64EncodedStringWithOptions(0)
    #   body = { image: encoded_image, level: 12, gas: 23 }

    #   AFMotion::JSON.post("http://localhost:9292/v1/detect.json", body) do |result|
    #     puts result.status_code
    #     puts result.body
    #   end
    # end

    true
  end
end
