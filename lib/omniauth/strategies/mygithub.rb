require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class MyGitHub < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://api.github.com',
        authorize_url: 'https://github.com/login/oauth/authorize',
        token_url: 'https://github.com/login/oauth/access_token'
      }

      uid { raw_info['id'] }

      info do
        {
          nickname: raw_info['login'],
          email: primary_email,
          name: raw_info['name'],
          image: raw_info['avatar_url']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def primary_email
        primary = emails.find { |email| email['primary'] && email['verified'] }
        primary && primary['email'] || nil
      end

      def emails
        access_token.get('user/emails').parsed
      end

      def raw_info
        @raw_info ||= access_token.get('user').parsed
      end
    end
  end
end


OmniAuth.config.add_camelization 'mygithub', 'MyGitHub'