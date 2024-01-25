class ApplicationController < ActionController::Base
    include ApplicationHelper

    def after_sign_in_path_for(resource)
        profile_index_path
    end
end
