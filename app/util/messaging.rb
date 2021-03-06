class Messaging
  class << self
    def show_error_message(message = "An error occurred.")
      UIAlertView.alloc.initWithTitle(
        "Error",
        message:message,
        delegate:nil,
        cancelButtonTitle:"Ok",
        otherButtonTitles:nil
      ).show
    end

    def show_message(title, message)
      UIAlertView.alloc.initWithTitle(
        title,
        message:message,
        delegate:nil,
        cancelButtonTitle:"Ok",
        otherButtonTitles:nil
      ).show
    end
  end
end
