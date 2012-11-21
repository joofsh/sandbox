class Article < ActiveRecord::Base
  attr_accessible :image, :title, :body, :tag_list, :article_author, :view_count

  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings
  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "100x100>"}
  belongs_to :author

    def tag_list
        return self.tags.join(", ")
    end

    def tag_list=(tags_string)
      self.taggings.destroy_all

      tag_name = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        tag_name.each do |tag_name|
          tag = Tag.find_or_create_by_name(tag_name)
          tagging = self.taggings.new
          tagging.tag_id = tag.id
        end
    end

    def count_up
      if self.view_count == nil
        self.view_count = 0
      end
      if self.view_count >= 0
       self.view_count += 1
      end
      self.save
    end

  def top_three_viewed
    Article.order('view_count desc').limit 3
  end

end