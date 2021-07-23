module Fastlane
  module Actions
    module SharedValues
      SPM_BUILD_XCFRAMEWORK_CUSTOM_VALUE = :SPM_BUILD_XCFRAMEWORK_CUSTOM_VALUE
    end

    class SpmBuildXcframeworkAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Building XCFramework..."

        # sh "shellcommand ./fastlane/actions/build_xcframework.sh"
        # sh "chmod +x fastlane/actions/build_xcframework.sh"
        sh "sh fastlane/actions/build_xcframework.sh"

        # Actions.lane_context[SharedValues::SPM_BUILD_XCFRAMEWORK_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Build XCFramework from your Swift Package."
      end

      def self.details
      end

      def self.available_options
      end

      def self.output
      end

      def self.return_value
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :mac
      end
    end
  end
end
