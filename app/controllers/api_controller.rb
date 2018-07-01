class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token

    def autocomplete_database
        q = params[:q]
        result = Array.new
        products = Product.where("name ILIKE '%#{q}%'").limit(100)

        products.each do |product|
            result << {
                "name" => product.name
            }
        end


        render :json => {"items" => result}
    end

    def autocomplete_elasticsearch
        q = params[:q]
        result = Array.new
        body = ElasticsearchWrapper.search_product q


        if body["hits"] && body["hits"]["hits"]
            body["hits"]["hits"].each do |hit|
                result << {
                    "name" => hit["_source"]["name"]
                }
            end
        end


        render :json => {"items" => result}
    end
end
