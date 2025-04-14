#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE_SHOT = 10
LAST_FRAME = 10

def get_shot(score)
  if score == 'X'
    STRIKE_SHOT
  else
    score.to_i
  end
end

def get_frames(scores)
  frame = []
  frames = []
  scores.each do |score|
    shot = get_shot(score)
    if frames.length < LAST_FRAME - 1 && (shot == STRIKE_SHOT || !frame.empty?)
      frame << shot
      frames << frame.clone
      frame.clear
    else
      frame << shot
    end
  end
  frames << frame
end

def calc_point(scores, frames)
  bonus_index = 0
  point = 0
  frames.each_with_index do |frame, index|
    bonus_index += frame.size
    unless index == LAST_FRAME - 1
      if frame[0] == STRIKE_SHOT
        frame << get_shot(scores[bonus_index]) + get_shot(scores[bonus_index + 1])
      elsif frame.sum == STRIKE_SHOT
        frame << get_shot(scores[bonus_index])
      end
    end
    point += frame.sum
  end
  point
end

scores = ARGV[0].split(',')
frames = get_frames(scores)
puts calc_point(scores, frames)
