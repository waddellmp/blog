class BlogPost < ApplicationRecord
  has_rich_text :content
  validates :title, presence: true
  validates :content, presence: true

  # This is a scope that returns all blog posts that have a published_at date
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at <= ?', Time.current) }
  scope(:scheduled, -> { where('published_at > ?', Time.current) })
  scope(:sorted, -> { order(arel_table[:published_at].desc.nulls_last) })

  def draft?
    published_at.nil?
  end

  def published?
    published_at && published_at <= Time.current
  end

  def scheduled?
    published_at && published_at > Time.current
  end
end
