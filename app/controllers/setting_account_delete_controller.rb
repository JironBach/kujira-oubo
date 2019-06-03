class SettingAccountDeleteController < ApplicationController
  def post
    index = params["delete_id_arr"]
    ActiveRecord::Base.transaction do
      Account.where(id: index).first.destroy!
    end

    redirect_to '/setting_account'
  end
end
