# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190604000857) do

  create_table "account", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "password"
    t.string "fullname"
    t.string "fullname_furigana"
    t.string "main_mail"
    t.string "cc_mail_01"
    t.string "cc_mail_02"
    t.integer "position", default: -1
    t.integer "setting_00", default: 0
    t.integer "setting_01", default: 0
    t.integer "setting_02", default: 0
    t.integer "s_group", default: -1
    t.integer "store", default: -1
    t.integer "cer_status", default: -1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delete_flg", default: 0
  end

  create_table "app_settings", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "company_name"
    t.string "contact_email"
    t.string "contact_tel"
    t.string "reception_time"
    t.string "mail_footer", limit: 4000
    t.integer "id"
  end

  create_table "app_status", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status_name"
    t.integer "follow_up", default: -1
    t.integer "delete_flg", default: 0
  end

  create_table "applicant", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "create_datetime"
    t.string "site"
    t.integer "store"
    t.string "name"
    t.string "email"
    t.string "tel"
    t.string "address"
    t.string "experience"
    t.integer "transportation"
    t.integer "status"
  end

  create_table "applicant_display", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "hour", default: -1
    t.string "icon"
    t.string "display_icon"
    t.datetime "updated_at"
  end

  create_table "applicants_info", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "unread_count", default: 0, null: false
    t.integer "deadline_count", default: 0, null: false
    t.integer "out_deadline_count", default: 0, null: false
    t.integer "today_interview_count", default: 0, null: false
    t.integer "id"
  end

  create_table "area", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "delete_flg", default: 0
  end

  create_table "auth", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "auto_capture", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "media_name"
    t.string "setting_name"
    t.string "login_url"
    t.string "login_id"
    t.string "password_1"
    t.string "password_2"
    t.date "past_data_date"
    t.date "auto_data_date"
    t.string "auto_data_time"
    t.datetime "auto_data_start_date"
    t.integer "auto_status", default: 0
    t.integer "link_store", default: -1
    t.date "request_date"
    t.integer "delete_flg", default: 0
  end

  create_table "auto_data_upload", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "capture_date_time"
    t.integer "status", default: 0
    t.integer "capture_num", default: 0
    t.string "message"
  end

  create_table "blacklist", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.string "name", limit: 200
    t.string "mail", limit: 200
    t.string "mail2", limit: 200
    t.string "tel", limit: 200
    t.string "tel2", limit: 200
  end

  create_table "brand", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.integer "job_type", default: -1
    t.string "memo", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delete_flg", default: 0
  end

  create_table "city", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.integer "prefecture"
  end

  create_table "current_job", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "del_flg", default: 0
  end

  create_table "current_job_alias", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "name"
    t.integer "del_flg", default: 0
  end

  create_table "deal_histry_memos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "applicant_id"
    t.string "tanto_name"
    t.string "contents", limit: 510
    t.datetime "submit_datetime"
  end

  create_table "division", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "email_template", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "temp_type"
    t.integer "auto_setting"
    t.string "name", default: ""
    t.string "subject", default: ""
    t.string "content", default: ""
    t.integer "min_age"
    t.integer "max_age"
    t.integer "gender"
    t.string "job", default: ""
    t.datetime "at_create"
    t.datetime "at_update"
    t.integer "status"
    t.integer "del_flg", default: 0
  end

  create_table "final_education", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "del_flg", default: 0
  end

  create_table "follow_up", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
  end

  create_table "interview_applicant", primary_key: ["interview", "applicant"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "interview", null: false
    t.integer "applicant", null: false
  end

  create_table "interview_group", primary_key: ["interview", "s_group"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "interview", null: false
    t.integer "s_group", null: false
  end

  create_table "interview_quota", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "interview_start_date"
    t.datetime "interview_end_date"
    t.date "start_date"
    t.date "end_date"
    t.integer "re_registration", default: 0
    t.integer "repeat_type", default: 0
    t.integer "repeat_day_mon", default: 0
    t.integer "repeat_day_tue", default: 0
    t.integer "repeat_day_wed", default: 0
    t.integer "repeat_day_thi", default: 0
    t.integer "repeat_day_fri", default: 0
    t.integer "repeat_day_sat", default: 0
    t.integer "repeat_day_sun", default: 0
    t.integer "repeat_week", default: 0
    t.date "repeat_end_date"
    t.string "store_name"
    t.string "group_name"
    t.string "interview_place"
    t.string "interview_place_address"
    t.integer "total_quota", default: 0
    t.string "note", limit: 2002
    t.string "interviewer_name"
    t.string "interviewer_email"
    t.string "contact_information", limit: 2002
    t.string "interview_memo", limit: 2002
  end

  create_table "interview_store", primary_key: ["interview", "store"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "interview", null: false
    t.integer "store", null: false
  end

  create_table "m_applicant", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "apply_date"
    t.integer "site_id", default: -1
    t.integer "store_id", default: -1
    t.string "raw_store_str", default: "", null: false
    t.string "job_category", limit: 510, default: ""
    t.string "name", limit: 200, default: ""
    t.string "name_furigana", limit: 200, default: ""
    t.integer "gender", default: -1
    t.string "tel", limit: 20, default: ""
    t.string "tel2", limit: 200, default: ""
    t.string "mail", limit: 200, default: ""
    t.string "mail2", limit: 200, default: ""
    t.string "post_code", limit: 20, default: ""
    t.string "address", limit: 1000, default: ""
    t.string "address2", limit: 1000, default: ""
    t.integer "experience_flg", default: 0
    t.integer "ticket_flg", default: 0
    t.integer "status", default: -1
    t.string "deal_histry_memo", limit: 200, default: ""
    t.datetime "birthday"
    t.datetime "welcome_date"
    t.integer "current_job", default: -1
    t.string "raw_current_job", default: ""
    t.integer "enable_mon", default: 0
    t.integer "enable_tue", default: 0
    t.integer "enable_wed", default: 0
    t.integer "enable_thi", default: 0
    t.integer "enable_fri", default: 0
    t.integer "enable_sat", default: 0
    t.integer "enable_sun", default: 0
    t.string "enable_week_memo", limit: 1024, default: ""
    t.integer "enable_morning", default: 0
    t.integer "enable_noon", default: 0
    t.integer "enable_evening", default: 0
    t.integer "enable_night", default: 0
    t.integer "enable_only_earlymorning", default: 0
    t.integer "enable_only_noon", default: 0
    t.integer "enable_only_night", default: 0
    t.string "enable_time_memo", limit: 1024, default: ""
    t.integer "final_education", default: -1
    t.datetime "gradu_date"
    t.string "school_name", limit: 510, default: ""
    t.string "school_subject", limit: 510, default: ""
    t.string "experience_job", limit: 1024, default: ""
    t.string "qualify", limit: 1024, default: ""
    t.string "self_pr", limit: 2048, default: ""
    t.string "remarks", limit: 2048, default: ""
    t.integer "read_flg", default: 0
    t.integer "dup", default: 0
    t.integer "del_flg", default: 0
    t.index ["apply_date"], name: "index_apply_date"
  end

  create_table "m_flow", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
  end

  create_table "m_log", primary_key: ["log_date", "site"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "log_date", null: false
    t.integer "site", null: false
    t.integer "status"
    t.integer "insert_count"
    t.string "message"
  end

  create_table "m_site", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "recruitment_site_id", null: false
    t.string "name", limit: 100, null: false
    t.string "sub_name", limit: 100, default: "", null: false
    t.string "user_id", limit: 100, null: false
    t.string "password", limit: 100, null: false
    t.string "extra1", null: false
    t.string "extra2", null: false
    t.string "extra3", null: false
    t.string "url", limit: 200, null: false
    t.integer "enterprise_cnt", null: false
    t.integer "no_scraping_flg", default: 0
    t.integer "order_key", default: 0, null: false
    t.integer "scraping_id", default: 0, null: false
    t.integer "del_flg", default: 0
  end

  create_table "m_store_term", primary_key: "store_term", id: :string, limit: 128, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "store", null: false
  end

  create_table "manual_capture", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "template_name"
    t.string "memo"
    t.integer "csv_line_no", default: 0
    t.integer "opt", default: 0
    t.string "field_0"
    t.string "field_1"
    t.string "field_2"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delete_flg", default: 0
  end

  create_table "notification", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "title"
    t.string "purpose"
    t.integer "situation", default: -1
    t.datetime "created_at"
    t.integer "delete_flg", default: 0
  end

  create_table "prefecture", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.integer "area", null: false
  end

  create_table "reachable", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id"
  end

  create_table "recruitment_site", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "site_name", limit: 100, null: false
    t.string "url", limit: 200, null: false
    t.integer "scraping_type"
    t.integer "order_key"
    t.integer "del_flg", default: 0
  end

  create_table "route", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.integer "rail_company"
  end

  create_table "s_group", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.string "manager", default: ""
    t.string "admin_comment", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delete_flg", default: 0
  end

  create_table "s_group_manager", primary_key: ["s_group", "manager"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "s_group", null: false
    t.integer "manager", null: false
  end

  create_table "s_group_store", primary_key: ["s_group", "store"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "s_group", null: false
    t.integer "store", null: false
  end

  create_table "site", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "station", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.integer "route"
  end

  create_table "status", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "follow_up", default: -1
    t.integer "del_flg", default: 0
  end

  create_table "store", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.string "company_name", default: ""
    t.string "company_furigana", default: ""
    t.integer "store_manager", default: -1
    t.integer "store_group", default: -1
    t.integer "work_loc_todoufuken", default: -1
    t.integer "work_loc_shikuchouson", default: -1
    t.string "access_todofuken", default: ""
    t.string "access_train_company", default: ""
    t.string "access_train_line", default: ""
    t.string "access_train_station", default: ""
    t.string "access_from_station", default: ""
    t.string "access_by", limit: 510, default: ""
    t.string "access_by_time", limit: 510, default: ""
    t.string "access_comment", default: ""
    t.integer "division", default: -1
    t.integer "division_todofuken", default: -1
    t.integer "division_shikuchouson", default: -1
    t.string "division_house_number", default: ""
    t.string "division_building_name", default: ""
    t.string "division_comment", default: ""
    t.string "telephone_0", default: ""
    t.string "telephone_1", default: ""
    t.string "telephone_2", default: ""
    t.string "telephone_comment", default: ""
    t.string "telephone_more_comment", default: ""
    t.string "admin_comment", limit: 1024, default: ""
    t.string "store_term", limit: 2048, default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip", default: ""
    t.integer "delete_flg", default: 0
  end

  create_table "store2", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.string "company_name", default: ""
    t.string "company_furigana", default: ""
    t.string "store_manager", default: ""
    t.integer "store_group", default: -1
    t.integer "work_loc_todoufuken", default: -1
    t.integer "work_loc_shikuchouson", default: -1
    t.string "access_todofuken", default: ""
    t.string "access_train_company", default: ""
    t.string "access_train_line", default: ""
    t.string "access_train_station", default: ""
    t.string "access_from_station", default: ""
    t.string "access_by", limit: 510, default: ""
    t.string "access_by_time", limit: 510, default: ""
    t.string "access_comment", default: ""
    t.integer "division", default: -1
    t.integer "division_todofuken", default: -1
    t.integer "division_shikuchouson", default: -1
    t.string "division_house_number", default: ""
    t.string "division_building_name", default: ""
    t.string "division_comment", default: ""
    t.string "telephone_0", default: ""
    t.string "telephone_1", default: ""
    t.string "telephone_2", default: ""
    t.string "telephone_comment", default: ""
    t.string "telephone_more_comment", default: ""
    t.string "admin_comment", default: ""
    t.string "store_term", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip", default: ""
  end

  create_table "store3", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.string "company_name", default: ""
    t.string "company_furigana", default: ""
    t.string "store_manager", default: ""
    t.integer "store_group", default: -1
    t.integer "work_loc_todoufuken", default: -1
    t.integer "work_loc_shikuchouson", default: -1
    t.json "access_infos"
    t.string "access_comment", default: ""
    t.integer "division", default: -1
    t.integer "division_todofuken", default: -1
    t.integer "division_shikuchouson", default: -1
    t.string "division_house_number", default: ""
    t.string "division_building_name", default: ""
    t.string "division_comment", default: ""
    t.string "telephone_0", default: ""
    t.string "telephone_1", default: ""
    t.string "telephone_2", default: ""
    t.string "telephone_comment", default: ""
    t.string "telephone_more_comment", default: ""
    t.string "admin_comment", default: ""
    t.string "store_term", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip", default: ""
  end

  create_table "store_manager", primary_key: ["store", "manager"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "store", null: false
    t.integer "manager", null: false
  end

  create_table "template_parameter", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "identification_character", limit: 16
    t.string "template_name", default: ""
    t.integer "media_name", default: 13
    t.string "recruit_title", default: ""
    t.string "job_category", default: ""
    t.string "store_name", default: ""
    t.string "name_disp_title", default: "名前"
    t.integer "name_disp_type", default: 1
    t.integer "name_disp_priority", default: 0
    t.integer "name_anyItem_flg", default: 0
    t.integer "name_close_flg", default: 0
    t.string "furigana_disp_title", default: "ふりがな"
    t.integer "furigana_disp_type", default: 1
    t.integer "furigana_disp_priority", default: 1
    t.integer "furigana_anyItem_flg", default: 0
    t.integer "furigana_close_flg", default: 0
    t.string "gender_disp_title", default: "性別"
    t.integer "gender_disp_type", default: 3
    t.integer "gender_disp_priority", default: 2
    t.integer "gender_anyItem_flg", default: 0
    t.integer "gender_close_flg", default: 0
    t.string "tel1_disp_title", default: "電話番号１"
    t.integer "tel1_disp_type", default: 1
    t.integer "tel1_disp_priority", default: 3
    t.integer "tel1_anyItem_flg", default: 0
    t.integer "tel1_close_flg", default: 0
    t.string "tel2_disp_title", default: "電話番号２"
    t.integer "tel2_disp_type", default: 1
    t.integer "tel2_disp_priority", default: 4
    t.integer "tel2_anyItem_flg", default: 0
    t.integer "tel2_close_flg", default: 0
    t.string "mail1_disp_title", default: "メールアドレス１"
    t.integer "mail1_disp_type", default: 1
    t.integer "mail1_disp_priority", default: 5
    t.integer "mail1_anyItem_flg", default: 0
    t.integer "mail1_close_flg", default: 0
    t.string "mail2_disp_title", default: "メールアドレス２"
    t.integer "mail2_disp_type", default: 1
    t.integer "mail2_disp_priority", default: 6
    t.integer "mail2_anyItem_flg", default: 0
    t.integer "mail2_close_flg", default: 0
    t.string "address_disp_title", default: "住所"
    t.integer "address_disp_type", default: 2
    t.integer "address_disp_priority", default: 7
    t.integer "address_anyItem_flg", default: 0
    t.integer "address_close_flg", default: 0
    t.string "birthday_disp_title", default: "生年月日"
    t.integer "birthday_disp_type", default: 5
    t.integer "birthday_disp_priority", default: 8
    t.integer "birthday_anyItem_flg", default: 0
    t.integer "birthday_close_flg", default: 0
    t.string "current_job_disp_title", default: "現在の職業"
    t.integer "current_job_disp_type", default: 4
    t.integer "current_job_disp_priority", default: 9
    t.integer "current_job_anyItem_flg", default: 0
    t.integer "current_job_close_flg", default: 0
    t.string "graduate_date_disp_title", default: "卒業年月日"
    t.integer "graduate_date_disp_type", default: 5
    t.integer "graduate_date_disp_priority", default: 10
    t.integer "graduate_date_anyItem_flg", default: 0
    t.integer "graduate_date_close_flg", default: 0
    t.string "school_name_disp_title", default: "学校名"
    t.integer "school_name_disp_type", default: 1
    t.integer "school_name_disp_priority", default: 11
    t.integer "school_name_anyItem_flg", default: 0
    t.integer "school_name_close_flg", default: 0
    t.string "major_disp_title", default: "専攻"
    t.integer "major_disp_type", default: 1
    t.integer "major_disp_priority", default: 12
    t.integer "major_anyItem_flg", default: 0
    t.integer "major_close_flg", default: 0
    t.string "experience_disp_title", default: "経験の有無"
    t.integer "experience_disp_type", default: 3
    t.integer "experience_disp_priority", default: 13
    t.integer "experience_anyItem_flg", default: 0
    t.integer "experience_close_flg", default: 0
    t.string "qualification_disp_title", default: "資格"
    t.integer "qualification_disp_type", default: 2
    t.integer "qualification_disp_priority", default: 14
    t.integer "qualification_anyItem_flg", default: 0
    t.integer "qualification_close_flg", default: 0
    t.string "self_pr_disp_title", default: "自己ＰＲ"
    t.integer "self_pr_disp_type", default: 2
    t.integer "self_pr_disp_priority", default: 15
    t.integer "self_pr_anyItem_flg", default: 0
    t.integer "self_pr_close_flg", default: 0
    t.string "reply_mail_address", default: ""
    t.string "reply_mail_subject", default: ""
    t.string "reply_mail_content", limit: 2000, default: ""
    t.integer "close_flg", default: 0
    t.integer "delete_flg", default: 0
    t.integer "max_count", default: 0
    t.index ["identification_character"], name: "identification_character", unique: true
  end

  create_table "train_company", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: ""
    t.integer "prefecture"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "failed_attempts"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
