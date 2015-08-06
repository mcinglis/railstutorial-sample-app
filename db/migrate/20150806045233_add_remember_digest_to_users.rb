
class AddRememberDigestToUsers < ActiveRecord::Migration

  def change
    add_column :users, :remember_digest, :string, limit: 32
  end

end

