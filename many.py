import math

t = float(input())

print( "%.20f,%.20f,%.20f,%.20f,%.20f" % (
  math.sin(t),
  math.cos(t),
  math.tan(t),
  math.atan(t),
  math.atan2(t,t/2)
))