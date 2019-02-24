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
  shell( "clang++ -std=c++17 -Wall sincpp.cpp -o bin/sincpp" )
end

def collect(cmd)
  shell(cmd).reject( &:empty? )
            .map(&:to_f)
end

def sinvalues
  (1..64).map{ |i|
    Math.sin(2**i)
  }
end

def strong(s,v)
  s==v ? v : "**#{v}**"
end

def show(data)
  keys = data.keys
  puts( "|θ|" + keys.map{ |k| k.to_s+"|" }.join )
  puts( "|:--|" + keys.map{ ":--:|" }.join )
  fmt = "%.3g"
  data[:cpp].size.times do |ix|
    cppval = fmt % data[:cpp][ix]
    row = keys.map{ |k| data[k][ix] }
    s = "|2**#{ix+1}|#{cppval}|" + (keys-[:cpp]).map{ |k|
      strong( cppval, fmt % data[k][ix] )+"|"
    }.join
    puts s
  end
end

def run
  data = {
    cpp: collect("bin/sincpp"),
    ruby: sinvalues,
    python3: collect( "python3 sin.py" ),
    node: collect( "node sin.js" ),
    groovy: collect( "groovy sin.groovy" ),
    go: collect("go run go/singo.go")
  }
  show(data)
end

build
run