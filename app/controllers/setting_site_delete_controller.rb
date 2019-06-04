class SettingSiteDeleteController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"

    MSite.where(id: params['delete_id_arr'].to_i).first.destroy!
    redirect_to '/setting_site'
  end

end
