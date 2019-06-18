class MSite < ApplicationRecord
  self.table_name = 'm_site'
  validates :recruitment_site_id, presence: { message: '掲載サイトは必須です。' }
  validates :name, presence: { message: '求人案件名は必須です。' }
  #validates :user_id, presence: { message: 'IDは必須です。' }
  #validates :password, presence: { message: 'パスワードは必須です。' }
  #validates :url, presence: { message: 'サイトアドレスは必須です。' }
  validates :no_scraping_flg, presence: { message: '自動取り込みは必須です。' }
end
