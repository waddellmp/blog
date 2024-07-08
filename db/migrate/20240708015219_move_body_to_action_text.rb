class MoveBodyToActionText < ActiveRecord::Migration[7.1]
  def change
    # Find each blog post (max: 1000 records at a time) and update the content attribute with the body attribute
    BlogPost.all.find_each do |blog_post|
      blog_post.update(content: blog_post.body)
    end

    # Remove the body column from the blog_posts table
    remove_column(:blog_posts, :body)
  end
end
