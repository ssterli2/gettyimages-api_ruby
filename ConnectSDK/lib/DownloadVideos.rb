require_relative "RequestBase"

class DownloadVideos < RequestBase

    attr_accessor :asset_id

	CONNECT_ROUTE = "/v3/downloads/videos" # mashery endpoint	
	@@search_route = CONNECT_ROUTE
	QUERY_PARAMS_NAMES = ["product_id","size"]	

	QUERY_PARAMS_NAMES.each do |key|
    define_method :"with_#{key}" do |value = true| 
            if (!key.include? "id") && (value.is_a?(String))
                value.downcase!
            end	
            build_query_params(key, value)
            return self
        end
    end
      
    public 	
    def with_id(asset_id)	
        self.asset_id = asset_id
        return self
    end

    def execute
        build_query_params("auto_download", "false")
        uri = @@search_route + "/" + self.asset_id
		return @http_helper.post(uri, @query_params)			
	end

end