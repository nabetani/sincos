require "./shell"

OPS = %w( O0 O1 O2 O3 Ofast)

OPTIONS = " -mtune=native -march=native "

def build
  OPS.each do |op|
    shell( "clang++ -#{op} #{OPTIONS} -std=c++17 -Wall heavy.cpp -o bin/heavy_clang_#{op} 2>&1" )
  end
  OPS.each do |op|
    shell( "g++-8 -#{op} #{OPTIONS} -std=c++17 -Wall heavy.cpp -o bin/heavy_gcc_#{op} 2>&1" )
  end
  shell( "go build -o bin/heavygo go/heavy.go 2>&1" )
  shell( "go build -gcflags '-N -l' -o bin/heavygo_O0 go/heavy.go 2>&1" )
end

def user(x)
  /(\d+\.\d+)\s*user/.match(x.last)[1]
end

def run(size)
  res=[]
  OPS.each do |op|
    puts( "clang / #{op}" )
    r=shell( "echo #{size}|time bin/heavy_clang_#{op} 2>&1" )
    res.push( "|clang++|-#{op}|#{user(r)}|" )
  end
  OPS.each do |op|
    puts( "gcc / #{op}" )
    r=shell( "echo #{size}|time bin/heavy_gcc_#{op} 2>&1" )
    res.push( "|g++-8|-#{op}|#{user(r)}|" )
  end
  puts( "go" )
  r=shell( "echo #{size}|time bin/heavygo 2>&1" )
  res.push( "|go||#{user(r)}|" )
  puts( "go / O0" )
  r=shell( "echo #{size}|time bin/heavygo_O0 2>&1" )
  res.push( "|go|-gcflags '-N -l'|#{user(r)}|" )
  puts( res.join("\n") )
end

build
run(5000)