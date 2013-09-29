# 500PX octopress plugin
# ----------------------
# Author: Nils Kuhnert (github.com/3c7)
# Description:
# Insert an image hosted via 500px using liquid tags
# Example:
# {% fhp 47564676 %}
# This will display my photo 'La Trappa'

require 'net/https'
require 'uri'
require 'json'

module Jekyll
	class FhpTag < Liquid::Tag
		def initialize(tag_name, config, token)
			super

			@set = config.strip

			@config = Jekyll.configuration({})['Fhp_Tag'] || {}

			@config['wrapper_class'] ||= 'fhp-wrapper'
			@config['description_tag']	||= 'p'
			@config['description_class'] ||= 'fhp-description'
			@config['description_wrapper_tag'] ||= 'div'
			@config['description_wrapper_class'] ||= 'fhp-description-wrapper'

			@config['image_size'] ||= '4'
			@config['consumer_key'] ||= 'null'
		end

		def render(context)
			html = '<div class="#{@config['wrapper_class']}">'
			html << '<a href="http://500px.com/photo/#{@set}">'
			html << '<img src="#{photo.image_url}">'
			html << '</a>'
			html << '<div class="fhp-exif-wrapper"><p class="fhp-exif"><span class="icon-exif"">Exif: </span>#{photo.focal_length}mm - ISO #{photo.iso} - #{photo.shutter_speed}s - f/#{photo.aperture}</p></div>'
			#html << '<#{@config['description_wrapper_tag']} class="#{@config['description_wrapper_class']}">'
			#html << '<h4>#{photo.title}</h4>'
			#html << '<#{@config['description_tag']} class="#{@config['description_class']}">'
			#html << '#{photo.description}'
			#html << '</#{@config['description_tag']}>'
			#html << '</#{@config['description_wrapper_tag']}>'
			html << '</div>'
			return html
		end

		def photo
			request = JSON.parse(json)
			@photo = photo.new(request['id'], request['title'], request['description'], request['focal_length'], request['iso'], request['shutter_speed'], request['aperture'], request['image_url'])
		end

		def json
			uri = URI.parse('https://api.500px.com/v1/photos/#{@set}?image_size=#{@config['image_size']}&consumer_key=#{@config['consumer_key']}')
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			return http.request(Net::HTTP::Get.new(uri.request_uri)).body
		end
	end

	class photo
		def initialize(id, title, description, focal_length, iso, shutter_speed, aperture, image_url)
			@id				= id
			@title 			= title
			@description 	= description
			@focal_length 	= focal_length
			@iso 			= iso
			@shutter_speed 	= shutter_speed
			@aperture 		= aperture
			@image_url		= image_url
		end

		def title
			return @title
		end

		def description
			return @description
		end

		def focal_length
			return @focal_length
		end

		def iso
			return @iso
		end

		def shutter_speed
			return @shutter_speed
		end

		def aperture
			return @aperture
		end

		def image_url
			return @image_url
		end
	end
end

Liquid::Template.register_tag('fhp', Jekyll::FhpTag)