class Product < ApplicationRecord
    include Elasticsearch::Model
	index_name    "products"
	document_type "product"

end
