# frozen_string_literal: true

class ::Hash
  # via https://stackoverflow.com/a/25835016/2257038
  def stringify_keys
    h = map do |k, v|
      v_str = v.instance_of?(Hash) ? v.stringify_keys : v

      [k.to_s, v_str]
    end
    h.to_h
  end

  # via https://stackoverflow.com/a/25835016/2257038
  def symbol_keys
    h = map do |k, v|
      v_sym = if v.instance_of? Hash
                v.symbol_keys
              else
                v
              end

      [k.to_sym, v_sym]
    end
    h.to_h
  end
end
