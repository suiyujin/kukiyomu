require 'net/http'
require 'json'

class LineBot
  def self.send
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    message = '心配してたよ'

    body = {
      to: [ENV.fetch('SUIYUJIN_MID'), ENV.fetch('SESTA_MID'), ENV.fetch('KADOWAKI_MID')],
      toChannel: 1383378250,
      eventType: "138311608800106203",
      content: { contentType: 1, toType: 1, text: message }
    }

    header = {
      'Content-Type' => 'application/json; charset=UTF-8',
      'X-Line-ChannelID' => ENV.fetch('CHANNEL_ID'),
      'X-Line-ChannelSecret' => ENV.fetch('CHANNEL_SECRET'),
      'X-Line-Trusted-User-With-ACL' => ENV.fetch('CHANNEL_MID')
    }

    res_message = client.post('/v1/events', body.to_json, header)
    res_stump = send_stump
  end

  def self.send_stump
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    body = {
      to: [ENV.fetch('SUIYUJIN_MID'), ENV.fetch('SESTA_MID'), ENV.fetch('KADOWAKI_MID')],
      toChannel: 1383378250,
      eventType: "138311608800106203",
      content: {
        contentType: 8,
        toType: 1,
        contentMetadata: { STKID: '34', STKPKGID: '2', STKVER: '10' }
      }
    }

    header = {
      'Content-Type' => 'application/json; charset=UTF-8',
      'X-Line-ChannelID' => ENV.fetch('CHANNEL_ID'),
      'X-Line-ChannelSecret' => ENV.fetch('CHANNEL_SECRET'),
      'X-Line-Trusted-User-With-ACL' => ENV.fetch('CHANNEL_MID')
    }

    client.post('/v1/events', body.to_json, header)
  end
end
