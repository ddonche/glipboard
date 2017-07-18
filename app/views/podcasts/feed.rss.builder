xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @podcast.title
    xml.image_url = @podcast.image.url
    xml.description @podcast.content
    xml.link podcast_url(@podcast)

    @episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.image_url = episode.image.url
        xml.description episode.content.truncate(300)
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.link podcast_url(@podcast)
        xml.guid podcast_episode_url(@podcast, episode)
      end
    end
  end
end