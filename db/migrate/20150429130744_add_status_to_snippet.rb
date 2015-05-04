class AddStatusToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :status, :integer, default: 0
    # 0 not sent, 1 Waiting for approval, 2 Approved, 3 Refused
    # When the migration occured just approved all the snippets
    Snippet.find_each do |snippet|
      snippet.update(:status => 2)
    end
  end
end
