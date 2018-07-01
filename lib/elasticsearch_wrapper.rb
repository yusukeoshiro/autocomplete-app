class ElasticsearchWrapper

    require 'net/http'
    require 'net/https'



	#execute search on the specified api e.g. "/stations/station/_search" and returns the result
    def self.search_product q
        payload = merge_print "elasticsearch_product_search_payload.json", [q]
        result = search "/products/product/_search", payload
        p result
    end


	def self.search api, payload
		url = ENV["ELASTICSEARCH_URL"] + api
		uri = URI.parse(url)
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true if uri.port == 443
		req = Net::HTTP::Get.new(uri)
		if uri.user.present? && uri.password.present?
			req.basic_auth uri.user, uri.password # this is for hosted elasticsearch like bonsai
		end
		req["Content-Type"] = "application/json"
		req.body = payload
		res = https.request( req )
		return JSON.parse res.body
	end


	def self.merge_print file_name, params
		file_path = Rails.root.to_s + "/config/merge_print/" + file_name
		content = File.read file_path
		content = content.squish
		params.each_with_index do |param,i|
			replace = "PARAM#{i+1}"
			content = content.gsub( replace, param )
		end
		return content
	end



end
