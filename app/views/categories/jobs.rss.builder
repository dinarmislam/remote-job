#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "We Work Remotly"
    xml.author "M. Dinar"
    xml.description "We Work Remotely is the best place to find remote jobs"
    xml.link root_url
    xml.language "en"

    for category in @categories
        xml.category category.name
        for job in category.jobs
          xml.item do
            xml.title job.job_title            
            image_url = job.logo.url(:medium)
            xml.author job.name
            xml.pubDate job.created_at.to_s(:rfc822)
            xml.description job.description
            xml.link job_url(job)
            xml.guid job_url(job)

            text = job.description
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.

            xml.description "<p>" + text + "</p>"
          end
        end
      end
    end
  end
