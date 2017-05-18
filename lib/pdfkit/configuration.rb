class PDFKit
  class Configuration
    attr_accessor :meta_tag_prefix, :default_options, :root_url
    attr_writer :verbose

    def initialize
      @verbose         = false
      @meta_tag_prefix = 'pdfkit-'
      @default_options = {
        :disable_smart_shrinking => false,
        :quiet => true,
        :page_size => 'Letter',
        :margin_top => '0.75in',
        :margin_right => '0.75in',
        :margin_bottom => '0.75in',
        :margin_left => '0.75in',
        :encoding => 'UTF-8'
      }
    end

    def wkhtmltopdf
      File.expand_path(File.join(Gem.loaded_specs['pdfkit'].full_gem_path, '/lib/bin/wkhtmltopdf'))
    end

    # def default_wkhtmltopdf
    #   File.expand_path(File.join(Gem.loaded_specs['pdfkit'].full_gem_path, '/bin/wkhtmltopdf'))
    # end

    def wkhtmltopdf=(path)
      # if File.exist?(File.expand_path(File.join(Gem.loaded_specs['pdfkit'].full_gem_path, '/bin/wkhtmltopdf')))
        @wkhtmltopdf = File.expand_path(File.expand_path(File.join(Gem.loaded_specs['pdfkit'].full_gem_path, '/bin/wkhtmltopdf')))
      # else
      #   warn "No executable found at #{default_path}. Will fall back to #{default_wkhtmltopdf}" unless File.exist?(default_path)
      #   @wkhtmltopdf = default_wkhtmltopdf
      # end
    end

    def quiet?
      !@verbose
    end

    def verbose?
      @verbose
    end
  end

  # def default_path
  #   File.expand_path(File.join(Gem.loaded_specs['pdfkit'].full_gem_path, '/bin/wkhtmltopdf'))
  # end

  class << self
    attr_accessor :configuration
  end

  # Configure PDFKit someplace sensible,
  # like config/initializers/pdfkit.rb
  #
  # @example
  #   PDFKit.configure do |config|
  #     config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  #     config.verbose     = true
  #   end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
