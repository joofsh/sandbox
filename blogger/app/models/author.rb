class Author < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body
  validates_confirmation_of :password, :message =>  "should match confirmation", :if => :password

  has_many :articles
  has_many :comments

  def article_list
          return self.articles.join(", ")
      end

      def article_list=(articles_string)
        self.articles.destroy_all

        article_title = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
          tag_name.each do |tag_name|
            tag = Tag.find_or_create_by_name(tag_name)
            tagging = self.taggings.new
            tagging.tag_id = tag.id
          end
      end
end
