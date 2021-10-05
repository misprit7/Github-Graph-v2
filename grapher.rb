require 'date'

# █████████████████████████
# █ ███ █     █  ████  ████
# █ ███ ███ ███  ████  ████
# █ █ █ ███ ███  ████  ████
# █ █ █ ███ ███  ████  ████
# █     █     █     █     █
# █████████████████████████

# 
# 
# 
# 
# 
# 
# 

# PATTERN = <<-EOF.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join
# XXXXXXXXXXXXXXXXXXXXXXXXX
# X XXX X     X  XXXX  XXXX
# X XXX XXX XXX  XXXX  XXXX
# X X X XXX XXX  XXXX  XXXX
# X X X XXX XXX  XXXX  XXXX
# X     X     X     X     X
# XXXXXXXXXXXXXXXXXXXXXXXXX
# EOF


PATTERN = <<-EOF.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
X   XXX   XXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXX
XXX  X  XXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXX
XXXX   XXXXX     XXX      XX     XX     X      X
XXX  X  XXXX  X  XX  XXX  X  XX  X    XXX   XXXX
X   XXX   XX      X  XXX  X      XX     X   XXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
EOF

MASK = PATTERN.split(//).map{|c| c == 'X'}

DAYSTART = Date.new(2020,1,5)
raise unless DAYSTART.wday == 0 #
DAYEND   = DAYSTART + (PATTERN.size*8)


# def test_pattern
#   (0..6).map{|n| (PATTERN.split(//)*3).each_with_index{|c,i| print c if i%7==n}; print "\n"}
# end

dates = DAYSTART.upto( DAYEND ).to_a

def on?(date)
  delta = (date - DAYSTART).to_i
  MASK[ delta % MASK.size ]
end

commit_dates = []
dates.each do |date|
  if on?(date)
    22.times{|i| commit_dates << date.to_time + i*3600}
  end
end

str_commit_dates = commit_dates.map(&:to_s)

commit_dates.each do |date|
  puts date
  File.open('random_list_of_dates', 'w') { |f| f << str_commit_dates.shuffle.first(12).join("\n") }
  `GIT_AUTHOR_NAME="misprit7" GIT_AUTHOR_EMAIL="xandernaumenko@gmail.com" GIT_AUTHOR_DATE="#{date}" GIT_COMMITTER_DATE="#{date}" git commit -am "#{date}"`
end