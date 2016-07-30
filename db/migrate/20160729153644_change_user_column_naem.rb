class ChangeUserColumnNaem < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :oauth_token, :token
    rename_column :users, :oauth_token_secret, :secret
  end
end
