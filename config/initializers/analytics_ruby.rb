require 'segment/analytics'

Analytics = Segment::Analytics.new({
   write_key: 'TOMHWg8LGgLuda6lKlk0ImPCChVLnk98',
   on_error: Proc.new { |status, msg| print msg }
})