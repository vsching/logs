require 'active_support/concern'

module Logs
  module Concerns
    module LogsLoader
      extend ActiveSupport::Concern

      included do
        before_action :load_logs
        before_action :load_logs_list

        def load_logs
          LOG_PATH = Rails.root + 'log/'
          
          file_name = params[:name] || Rails.env

          if File.exist?(LOG_PATH + (file_name + '.log'))
            @logs = Logs::Viewer.call(file_name).read
          else
            @logs = nil
          end
        end

        def load_logs_list
          @log_files = Logs::LogFiles.all
        end
      end
    end
  end
end
