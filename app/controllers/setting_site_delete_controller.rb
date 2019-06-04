class SettingSiteDeleteController < ApplicationController
  def post
    idArray = params['delete_id_arr'].split(",")
    idArray.each do |id|
      begin
        MSite.where(id: id.to_i).first.destroy!
      rescue
      end
    end
    redirect_to '/setting_site'
  end

end
