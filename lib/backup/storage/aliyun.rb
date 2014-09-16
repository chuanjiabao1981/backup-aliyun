require "carrierwave-aliyun"
require "base64"

module Backup
  module Storage
    class Aliyun < Base
      attr_accessor :bucket,:access_key_id,:access_key_secret,:aliyun_internal, :aliyun_area, :content_type, :path

      def initialize(model, storage_id = nil, &block)
        super(model, storage_id)

        @path ||= 'backups'

        instance_eval(&block) if block_given?
      end

      private

      def connection
        return @connection if @connection
        opts = {
          :aliyun_access_id => self.access_key_id,
          :aliyun_access_key => self.access_key_secret,
          :aliyun_bucket => self.bucket,
          :aliyun_area => self.aliyun_area || 'cn-hangzhou',
          :aliyun_internal => self.aliyun_internal || false,
        }
        Logger.info "#{opts}"
        @connection = CarrierWave::Storage::Aliyun::Connection.new(opts)
      end

      def transfer!
        remote_path = remote_path_for(@package)

        @package.filenames.each do |filename|
          src = File.join(Config.tmp_path, filename)
          dest = File.join(remote_path, filename)
          Logger.info "#{storage_name} uploading '#{ dest }'..."
          File.open(src, 'r') do |file|
            connection.put(dest, file, options={:content_type => self.content_type || "application/octet-stream"})
          end
        end
      end

      def remove!(package)
        remote_path = remote_path_for(package)
        Logger.info "#{storage_name} removing '#{remote_path}'..."
        connection.delete(remote_path)
      end
    end
  end
end
