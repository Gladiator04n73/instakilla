class AddArticleIdToPostSubscriptions < ActiveRecord::Migration[7.2]
  def change
    add_column :post_subscriptions, :article_id, :integer
  end
end
