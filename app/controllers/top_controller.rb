class TopController < ApplicationController
  def show
    @applicant_info = ApplicantInfo.last

    @loginAccountObj = session["loginAccountObj"]
    @notificationArray = Notification.where(delete_flg: 0).all # QUESTION
    @nearDeadLineCount = @applicant_info.nil? ? 0 : @applicant_info.deadline_count
    @outOfDeadLineCount = @applicant_info.nil? ? 0 : @applicant_info.out_deadline_count
    @todayInterviewCount = @applicant_info.nil? ? 0 : @applicant_info.today_interview_count
    @unreadCount         = @applicant_info.nil? ? 0 : @applicant_info.unread_count
    @sidebar_collapse = cookies['sidebar_collapse']

    ss = @loginAccountObj.nil? ? '' : @loginAccountObj['fullname']
    @pict = ss.slice(0, 1);

    render :show
  end
end
