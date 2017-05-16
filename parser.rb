require "yaml"
require "pp"
require "stringio"
file = YAML.load(File.read("output.yaml"))

file["definitions"].each do |key, value|
  str = StringIO.new
  allOf = value["allOf"]

  values = []
  unless allOf
    structdef = []
    typedef = []
    str << "defmodule Pagerduty.#{key} do\r\n"
    str << "  @moduledoc ~S\"\"\"\r\n"

    str << "  ## Attributes\r\n"

    value["properties"].each do |prop|

        structdef << "#{prop[0]}: nil"
        description = prop[1].fetch("description", nil)
        default = prop[1].fetch("default", nil)
        enum = prop[1].fetch("enum", nil)
        formatstr = prop[1].fetch("formant", nil)
        items = prop[1].fetch("items", nil)
        maximum = prop[1].fetch("maximum", nil)
        maxlength = prop[1].fetch("maxlength", nil)
        minLength = prop[1].fetch("minLength", nil)
        minimum = prop[1].fetch("minimum", nil)
        readOnly = prop[1].fetch("readOnly", nil)
        type = prop[1].fetch("type", nil)
        case type
        when "string"
          typedef << "#{prop[0]}: String.t"
        when "array"
          typedef << "#{prop[0]}: list()"
        when "integer"
          typedef << "#{prop[0]}: integer"
        when "object"
          typedef << "#{prop[0]}: %Pagerduty.{}"
        when "boolean"
          typedef << "#{prop[0]}: boolean"
        else
          typedef << "#{prop[0]}: String.t"          
        end
        
        str << "    * `@#{prop[0]}`: #{description}"
        str << " in #{formatstr} format" if formatstr
        if enum
          str << " valid options are: \r\n"
          enum.each do |item|
            str << "      * `#{item}`\r\n"
          end
        end
        str << " (defaults to #{default})" if default
        str << " (maxlength #{maxlength})" if maxlength
        str << " (minLength #{minLength})" if minLength
        str << " (maximum of #{maximum})" if maximum
        str << " (minimum of #{minimum})" if minimum
        str << "\r\n"
    end
      str << "  \"\"\"\r\n"
      str << "  defstruct #{structdef.join(", ")}\r\n"
      str << "  @type t :: %__MODULE__{\r\n"
      str << "    #{typedef.join(",\r\n    ")}\r\n"
      str << "  }\r\n"
      str << "end"

    # puts str.string
      File.open("./lib/pagerduty/struct/#{key}.sex", "wb") { |file| file.write(str.string) }
    # exit
  end
end