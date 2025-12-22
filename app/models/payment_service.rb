require 'faraday'
require 'json'
require 'openssl'
require 'base64'

class PaymentService
  API_BASE = "http://111.10.175.176:18104"

  def initialize(api_key:, api_secret:)
    @api_key = api_key
    @api_secret = api_secret
    @conn = Faraday.new(url: API_BASE) do |f|
      f.request :json
      f.response :json, parser_options: { symbolize_names: true }
      f.adapter Faraday.default_adapter
    end
  end

  def generate_signature(payload, timestamp)
    timestamp = Time.now.to_i.to_s
    body_str = JSON.generate(payload.sort.to_h)
    sign_str = "#{timestamp}#{body_str}"
    OpenSSL::HMAC.hexdigest(
      'SHA256',
      @api_secret,
      sign_str
    )
  end

  def create_order(merchant_order_id:, amount:, chain:, callback_url:)
    payload = {
      merchant_order_id: merchant_order_id,
      amount: amount,
      chain: chain,
      callback_url: callback_url
    }
    timestamp = Time.now.to_i.to_s
    signature = generate_signature(payload, timestamp)

    response = @conn.post("/api/orders") do |req|
      req.headers["X-API-KEY"] = @api_key
      req.headers["X-SIGNATURE"] = signature
      req.headers["X-TIMESTAMP"] = timestamp
      req.body = payload
    end
  end

  def query_order(order_id)
    payload = {}
    timestamp = Time.now.to_i.to_s
    signature = generate_signature(payload, timestamp)

    response = @conn.get("/api/orders?order_id=#{order_id}") do |req|
      req.headers["X-API-KEY"] = @api_key
      req.headers["X-SIGNATURE"] = signature
      req.headers["X-TIMESTAMP"] = timestamp
    end

    response.body
  end
end
