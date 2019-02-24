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

def build
  shell( "clang++ -std=c++17 -Wall many.cpp -o bin/many" )
end

def collect( cmd )
  s = shell(cmd)
  s.join.strip.split(",").map(&:to_f)
end

def run(val)
  data = {
    cpp: collect("echo #{val}|bin/many"),
    node: collect("echo #{val}|node many.js"),
    python3: collect("echo #{val}|python3 many.py"),
    grooby: collect("echo #{val}|groovy many.groovy" ),
    go: collect("echo #{val}|go run go/many.go"),
  }
  p data
end

build
run(1e16)
