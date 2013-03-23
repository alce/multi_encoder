require 'helpers'

module MultiEncoder
  class Railtie < ::Rails::Railtie
    initializer 'multi-encoder.initialize' do
      ActiveSupport.on_load :action_view do
        include MultiEncoder::Helpers
      end
    end
  end
end
