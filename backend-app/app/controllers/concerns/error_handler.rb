module ErrorHandler
  def self.included(klass)
    klass.class_eval do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    end
  end

  private

  def record_not_found(_e)
    render_error('not_found', _e, 404)
  end

  def record_invalid(_e)
    render_error('record_invalid', _e, 422)
  end

  def render_error(error, message, status_code)
    render json: { error:, message: message.to_s }, status: status_code
  end
end