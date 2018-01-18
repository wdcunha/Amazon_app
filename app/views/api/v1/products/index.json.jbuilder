json.array! @products  do |product|
  json.id product.id
  json.title product.title.titleize
  # You can define an custom key for you json
  # response. The line below will add the key "stuff"
  # with the value "carrot" to JSON object that is returned.
  # json.stuff "carrot"
  json.created_at product.created_at.to_formatted_s(:db)
  json.updated_at product.updated_at.to_formatted_s(:db)

  # Database columns that are empty will show up as `null` in
  # JSON.

  # To create objects, specify a field `json.<field_name>`
  # then pass it a block and define all its properties
  # inside as below:
  json.author do
    json.id product.user.id
    json.first_name product.user.first_name
    json.last_name product.user.last_name
    json.full_name product.user.full_name
  end
end
