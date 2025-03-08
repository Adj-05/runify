module Api::Request
  def request(method, url, body: nil, headers: {})
    default_headers = { 'Content-Type' => 'application/json' }

    headers = default_headers.merge(headers)

    options = { headers: }

    if method == :post && body.present?
      options[:body] = body.to_json
    end

    response = HTTParty.send(method, url, options)

    if response.success?
      return response
    else
      Rails.logger.error("API error: #{response.body}")
      raise StandardError, "API request failed with status #{response.code}: #{response.body}"
    end
  end
end
