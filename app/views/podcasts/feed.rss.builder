title       = @podcast.title
author      = @podcast.user.username
description = @podcast.description
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
    xml.itunes :author, author
    xml.itunes :explicit, 'explicit'
    xml.itunes :image, image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'chris@gorails.com'
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
        xml.enclosure url: episode.download_url, length: episode.file_size, type: 'audio/mp3'
        xml.link podcast_episode_url(@podcast, episode)
        xml.guid({isPermaLink: "false"}, episode.slug)
        xml.itunes :author, author
        xml.itunes :subtitle, truncate(episode.description, length: 150)
        xml.itunes :summary, episode.description
        xml.itunes :explicit, 'yes'
        xml.itunes :duration, episode.length
      end
    end
  end
end