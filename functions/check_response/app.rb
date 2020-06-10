require 'aws-sdk'

############################################
# レスポンスチェック
############################################
def lambda_handler(event:, context:)
  url   = event['url']
  uri   = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.scheme === "https"
  headers = { "Content-Type" => "text/html" }

  begin
    response  = http.get(uri.path, headers)
    result = {
      response_code: response.code,
      uri: uri.to_s,
      msg: response.msg,
      header: response.header,
    }
  rescue => e
    result = {
      uri: uri.to_s,
      msg: e.message,
    }
  end

  {
    statusCode: 200,
    body: {
      message: result[:msg],
    }.to_json,
    result:  result
  }
end
