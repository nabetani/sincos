# frozen_string_literal: true

require "open3"

def shell(cmd)
  lines=[]
  Open3.popen3(cmd) do |_, o, _, w|
    o.each do |line|
      lines.push(line)
      puts line
    end
    raise "fail" unless w.value.success?
  end
  lines
end

