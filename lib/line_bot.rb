require 'net/http'
require 'json'

class LineBot
  def self.send
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    message = '心配してるよ'

    body = {
      to: [ENV.fetch('SEND_MID')],
      toChannel: 1383378250,
      eventType: "138311608800106203",
      content: { contentType: 1, toType: 1, text: message }
    }

    header = {
    'Content-Type' => 'application/json; charser=UTF-8',
    'X-Line-ChannelID' => ENV.fetch('CHANNEL_ID'),
    'X-Line-ChannelSecret' => ENV.fetch('CHANNEL_SECRET'),
    'X-Line-Trusted-User-With-ACL' => ENV.fetch('CHANNEL_MID')
    }

    res = client.post('/v1/events', body.to_json, header)
  end
end
