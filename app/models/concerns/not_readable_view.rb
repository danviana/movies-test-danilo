module NotReadableView
  extend ActiveSupport::Concern

  included do
    def readonly?
      true
    end
  end
end
