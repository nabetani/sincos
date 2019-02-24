# frozen_string_literal: true

require "./shell"

def build
  shell( "clang++ -std=c++17 -Wall many.cpp -o bin/many" )
end

def to_f(x)
  case x
  when /\-inf/i
    -Float::INFINITY
  when /inf/i
    Float::INFINITY
  when /nan/i
    Float::NAN
  else
    x.to_f
  end
end

def collect( cmd )
  s = shell(cmd)
  s.join.strip.split(",").map{ |x| to_f(x) }
end

def strong( cpp, v )
  cpp==v ? v : "**#{v}**"
end

def show( val, data )
  puts( "## t = #{String===val ? val : ('%g' % val)}" )
  puts
  procs = %w!sin(t) cos(t) tan(t) atan(t) atan2(t,t/2)!
  puts( "|処理系|"+procs.map{ |x| x+"|" }.join )
  puts( "|:--|"+procs.map{ ":--:|" }.join )
  fmt = "%.3g"
  cpp = data[:"c++"].map{ |x| fmt % x }
  data.each do |k,v|
    puts( "|#{k}|"+v.map.with_index{ |x,ix| strong(cpp[ix], fmt % x)+"|" }.join )
  end
  puts
end

def run(val)
  data = {
    :"c++"=>collect("echo #{val}|bin/many"),
    node: collect("echo #{val}|node many.js"),
    python3: collect("echo #{val}|python3 many.py"),
    groovy: collect("echo #{val}|groovy many.groovy" ),
    go: collect("echo #{val}|go run go/many.go")
  }
  show(val, data)
end

build
[1e12, 1e14, 1e16, 1e20, 1e308, "1.5707963267948966"].each do |v|
  run(v)
end
