module ErrorHandler
  def self.included(klass)
    klass.class_eval do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    end
  end

  private

  def record_not_found(_e)
    render json: { error: :not_found, message: _e.to_s }, status: 404
  end
end