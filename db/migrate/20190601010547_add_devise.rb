class AddDevise < ActiveRecord::Migration[5.1]
  def change
    ## Database authenticatable
    #add_column :users, :email, :string
    #add_column :users, :encrypted_password, :string

    ## Recoverable
    #add_column :users,  :reset_password_token, :string
    #add_column :users,  :reset_password_sent_at, :datetime

    ## Rememberable
    #add_column :users,  :remember_created_at, :datetime

    ## Trackable
    #add_column :users,  :sign_in_count, :datetimedatetime
    #add_column :users,  :current_sign_in_at, :datetime
    #add_column :users,  :last_sign_in_at, :datetime
    #add_column :users,  :current_sign_in_ip, :string
    #add_column :users,  :last_sign_in_ip, :string

    ## Confirmable
    #add_column :users,  :confirmation_token, :string
    #add_column :users,  :confirmed_at, :datetime
    #add_column :users,  :confirmation_sent_at, :datetime
    #add_column :users,  :unconfirmed_email, :string # Only if using reconfirmable

    ## Lockable
    add_column :users,  :failed_attempts, :string # Only if lock strategy is :failed_attempts
    add_column :users,  :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :users,  :locked_at, :datetime
  end
end
