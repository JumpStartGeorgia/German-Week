class TimePickerInput
  include Formtastic::Inputs::Base
    def to_html
      format = options[:format] || '%Y/%m/%d %H:%M'
      input_wrapping do
        label_html <<
        builder.text_field(method, datetimepicker_options(format, object.send(method)).merge(options))
      end
    end
    # Generate html input options for the datetimepicker_input
    #
    def datetimepicker_options(format, value = nil)
      datetimepicker_options = {:value => value.try(:strftime, format), :class => 'ui-timepicker'}
    end

    def input_html_options
      {
        :class => 'ui-timepicker'
      }.merge(super)
    end
end

