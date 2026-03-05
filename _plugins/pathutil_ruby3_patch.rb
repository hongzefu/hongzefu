# frozen_string_literal: true

# Jekyll 3 pulls in pathutil 0.16.x, whose File.read/binread calls use the
# pre-Ruby-3 keyword argument style. That breaks `jekyll serve` watch mode on
# Ruby 3 with `no implicit conversion of Hash into Integer`.
return unless Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.0")

class Pathutil
  def read(*args, **kwd)
    kwd[:encoding] ||= encoding

    if normalize[:read]
      File.read(self, *args, **kwd).encode(
        universal_newline: true
      )
    else
      File.read(self, *args, **kwd)
    end
  end

  def binread(*args, **kwd)
    kwd[:encoding] ||= encoding

    if normalize[:read]
      File.binread(self, *args, **kwd).encode(
        universal_newline: true
      )
    else
      File.binread(self, *args, **kwd)
    end
  end
end
