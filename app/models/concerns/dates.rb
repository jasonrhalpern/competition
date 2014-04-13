module Dates
  extend ActiveSupport::Concern

  module ClassMethods
    def current_date
      Date.current
    end
  end

end