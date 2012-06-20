require 'sass'

module Sprockets
  class SassCacheStore < ::Sass::CacheStores::Base
    attr_reader :environment

    def initialize(environment)
      @environment = environment
    end

    def _store(key, version, sha, contents)
      environment.cache_set(path_to(key), {:version => version, :sha => sha, :contents => contents})
    end

    def _retrieve(key, version, sha)
      if obj = environment.cache_get(path_to(key))
        return unless obj[:version] == version
        return unless obj[:sha] == sha
        obj[:obj]
      else
        nil
      end
    end

    def path_to(key)
      raise
      "sass/#{key}"
    end
  end
end
