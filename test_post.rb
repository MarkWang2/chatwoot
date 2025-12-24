require "faraday"
require "json"

conn = Faraday.new(url: "http://localhost:3000") do |f|
  f.request :json
  f.response :json
  f.adapter Faraday.default_adapter
end

params = {
  order_id: '2170bc1e-b740-4781-81b5-e57253c01fd6',
  status: "success",
  amount: "100"
}

response = conn.post("/api/v1/accounts/payment_callback") do |req|
  req.headers["Content-Type"] = "application/json"
  req.headers["api_access_token"] = "ZrhuLQPvvWxquYwXtkDbSpV5"
  req.body = params
end

puts response.status
puts response.body
