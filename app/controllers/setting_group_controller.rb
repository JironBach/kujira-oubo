class SettingGroupController < ApplicationController
  def show
    render 'setting_group'
  end

  def post
    if !params['searchName'].nil?
    end

    render 'setting_group'
  end

end
