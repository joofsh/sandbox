module ArticlesHelper

    def tag_links(tags)
      links = tags.collect{|tag| link_to tag.name, tag_path(tag) }
      return links.join(", ").html_safe
    end

    def article_links(articles)
          links = articles.collect{|article| link_to article.title, article_path(article) }
          return links.join(", ").html_safe
    end

end
