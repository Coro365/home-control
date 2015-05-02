require "open-uri"

class Timer

	DAY = 86400
	HOUR = 3600
	MINIT = 60

	def timer(action, limit_sec)
		sleep(limit_sec)
		open("http://control.local:4567/#{action}").read
	end

	def to_sec(hour, minit)
		return HOUR * hour.to_i + MINIT * minit.to_i
	end

	def to_relative_time(time)	#22:00 => after 4hour

		now = Time.now

		hour, minit = time.split(":")

		#Target time (Provisional)
		target_time_p = Time.new(now.year, now.month, now.day, hour.to_i, minit.to_i, 0, "+09:00")

		if target_time_p > now
			#Future
			target_time = target_time_p
		else
			#Past
			target_time = target_time_p + 1 * DAY
		end

		relative_sec = target_time - now
		return relative_sec.floor
	end

	def to_absolute_time(hour, minit)
		return Time.now + hour.to_i * HOUR + minit.to_i * MINIT
	end

end
