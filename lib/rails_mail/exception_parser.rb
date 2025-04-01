# frozen_string_literal: true

module RailsMail
  class ExceptionParser
    attr_reader :raw

    def initialize(raw)
      @raw = raw
    end

    def valid_format?
      return false unless @raw.present?
      @raw.include?("occurred in")
    end

    def parse
      return {} unless @raw

      # Extract the error information from the first few lines
      error_info = extract_error

      # Extract sections using a more direct approach
      sections = {
        "Data" => extract_section("Data"),
        "Request" => extract_section("Request"),
        "Session" => extract_section("Session"),
        "Backtrace" => extract_section("Backtrace"),
        "Environment" => extract_section("Environment")
      }

      {
        error: error_info,
        data: parse_section_content(sections["Data"]),
        request: parse_section_content(sections["Request"]),
        session: parse_section_content(sections["Session"]),
        backtrace: parse_backtrace(sections["Backtrace"]),
        environment: parse_section_content(sections["Environment"])
      }
    end

    def extract_error
      # Look for the error line pattern - supporting both "A" and "An"
      error_match = @raw.match(/^A(?:n)? ([\w:]+) occurred in ([^:]+):\r\n\r\n\s+(.*?)\r\n\s+(.+?)\r\n/m)
      return {} unless error_match

      {
        type: error_match[1],
        location: error_match[2],
        message: error_match[3],
        backtrace_line: error_match[4]
      }
    end

    def extract_section(section_name)
      # Match the section header and everything until the next section header or end of string
      section_regex = /^-+\r\n#{Regexp.escape(section_name)}:\r\n-+\r\n(.*?)(?=\r\n-+\r\n|\z)/m
      match = @raw.match(section_regex)
      match ? match[1] : ""
    end

    def parse_section_content(content)
      return {} unless content && !content.empty?

      result = {}
      content.split("\r\n").each do |line|
        line = line.strip
        # Handle lines that start with * and have indentation
        if line.start_with?("*")
          # Remove the asterisk and any leading whitespace
          key_value = line.sub(/^\*\s*/, "").split(":", 2)
          if key_value.length == 2
            key = key_value[0].strip
            value = key_value[1].strip
            result[key] = value if key && !key.empty?
          end
        end
      end
      result
    end

    def parse_backtrace(content)
      return [] unless content && !content.empty?

      # Split by Windows-style line endings and extract non-empty lines
      lines = content.split("\r\n").map(&:strip).reject(&:empty?)
      # Filter out lines that start with * (which would be key-value pairs)
      lines.reject { |line| line.start_with?("*") }
    end
  end
end
