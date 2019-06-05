class SettingAccountDeleteController < ApplicationController
  def post
    idArray = params["delete_id_arr"].split(",")
    idArray.each do |id|
      account = Account.where(id: id.to_i).first
      unless account.nil?
        account.delete_flg = 1
        account.save!
      end
    end

    redirect_to '/setting_account'
  end
end
