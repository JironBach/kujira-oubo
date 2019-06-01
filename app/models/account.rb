class Account < ApplicationRecord
  self.table_name = 'account'
  user_agent = Thread.current[:request].user_agent
  session = Thread.current[:request].session
end
