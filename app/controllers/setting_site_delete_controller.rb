class SettingSiteDeleteController < ApplicationController
  def post
    idArray = params['delete_id_arr'].split(",")
    idArray.each do |id|
      m_site = MSite.where(id: id.to_i).first
      unless m_site.nil?
        m_site.del_flg = 1
        m_site.save!
      end
    end
    redirect_to '/setting_site'
  end

end
