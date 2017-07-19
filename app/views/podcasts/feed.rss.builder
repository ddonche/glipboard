title       = @podcast.title
author      = @podcast.user
description = @podcast.content
image       = @podcast.image.url

xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:media" => "http://search.yahoo.com/mrss/" do
  xml.channel do
    xml.title @podcast.title
    xml.link podcast_url(@podcast)
    xml.description description
    xml.language 'en'
    xml.pubDate @episodes.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.created_at.to_s(:rfc822)
    xml.itunes :author, author.username
    xml.itunes :explicit, 'explicit'
    xml.itunes :image, image
    xml.itunes :owner do
      xml.itunes :name, author.username
      xml.itunes :email, author.email
    end
    xml.itunes :block, 'no'
    xml.itunes :category, text: 'Technology' do
      xml.itunes :category, text: 'Software How-To'
    end
    xml.itunes :category, text: 'Education' do
      xml.itunes :category, text: 'Training'
    end

    @episodes.each do  |episode|
      xml.item do
        xml.title episode.title
        xml.summary episode.content.truncate(300)
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.link podcast_episode_url(@podcast, episode)
        xml.guid({isPermaLink: "false"}, episode.slug)
        xml.itunes :author, author
        xml.itunes :subtitle, truncate(episode.content, length: 150)
        xml.itunes :summary, episode.content
        xml.itunes :explicit, 'yes'
        
        text = @podcast.content
        if @podcast.image
          image_tag = "<p><img src='" + @podcast.image.url + "' /></p>" if @podcast.image
          text = image_tag + text
        end
        xml.description "<p>" + text + "</p>"
      end
    end
  end
end